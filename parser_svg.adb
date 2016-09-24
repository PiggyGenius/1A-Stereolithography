WITH Ada.Strings.Equal_Case_Insensitive,Ada.Strings.Unbounded,Ada.Text_IO,Ada.Float_Text_IO,Math,STL;
USE Ada.Strings.Unbounded,Ada.Text_IO,Ada.Float_Text_IO,Math,STL;

PACKAGE BODY Parser_Svg IS
   pos: Point2D;

   FUNCTION NCasEqual(left,right: String) RETURN Boolean RENAMES Ada.Strings.Equal_Case_Insensitive;

   PROCEDURE Chargement_Bezier(Nom_Fichier,Fichier_STL: String;L: OUT Liste) IS
      File: File_Type;
      F:Liste_Facettes.Liste;
      x,y,relative: Float;
      c: Character;
      c_path: Character;
      str: Unbounded_String;
      P2,C1,C2: Point2D;
   BEGIN
      pos(1):=0.0;pos(2):=0.0;
      Open(File,In_File,Nom_Fichier);
      WHILE NOT End_Of_File(File) LOOP
         LOOP get(file,c); EXIT WHEN Character'Pos(c) IN 65..122; END LOOP;
         IF c='d' THEN
            get(file,c);
            IF c='=' THEN
               get(file,c);
               LOOP
                  get(file,c);
                  IF c IN Upper OR c IN Lower THEN
                     c_path:=c;
                     get(file,c);
                     get(file,x);
                     get(file,c);
                  ELSE
                     str:=To_Unbounded_String(c&"");
                     LOOP get(file,c); EXIT WHEN (c=',' OR c=' '); str:=str&c; END LOOP;
                     x:=Float'Value(To_String(str));
                  END IF;
                  IF NCasEqual(c_path&"","M") THEN
                     Creation(L,F);Sauvegarder(Fichier_STL,F);Vider(L);
                     get(file,y);get(file,c);
                     Load_Drawing(L,c_path,x,y);
                  ELSIF NCasEqual(c_path&"","H") THEN
                     Load_Drawing(L,c_path,x,0.0);
                  ELSIF NCasEqual(c_path&"","V") THEN
                     Load_Drawing(L,c_path,0.0,x);
                  ELSIF NCasEqual(c_path&"","L") THEN
                     get(file,y);get(file,c);
                     Load_Drawing(L,c_path,x,y);
                  ELSE
                     IF c_path IN Upper THEN relative:=0.0; ELSE relative:=1.0; END IF;
                     get(file,y);get(file,c);
                     C1(1):=pos(1)*relative+x;C1(2):=pos(2)*relative+y;
                     get(file,x);get(file,c);
                     get(file,y);get(file,c);
                     IF NCasEqual(c_path&"","C") THEN
                        C2(1):=pos(1)*relative+x;C2(2):=pos(2)*relative+y;
                        get(file,x);get(file,c);
                        get(file,y);get(file,c);
                        P2(1):=pos(1)*relative+x;P2(2):=pos(2)*relative+y;
                        Bezier(pos,C1,C2,P2,100,L);
                        pos(1):=P2(1);pos(2):=P2(2);
                     ELSIF NCasEqual(c_path&"","Q") THEN
                        P2(1):=pos(1)*relative+x;P2(2):=pos(2)*relative+y;
                        Bezier(pos,C1,P2,100,L);
                        pos(1):=P2(1);pos(2):=P2(2);
                     ELSE
                        RAISE CONSTRAINT_ERROR;
                     END IF;
                  END IF;
                  EXIT WHEN c='"';
               END LOOP;
               EXIT; 
            ELSE
               Skip_Line(file);
            END IF;
         ELSE
            Skip_Line(file);
         END IF;
      END LOOP;
      Close(File);
   END;

   PROCEDURE Load_Drawing(L: OUT Liste;path: Character;x,y: Float) IS
      relative: Float;
   BEGIN
      IF path IN Upper THEN relative:=0.0; ELSE relative:=1.0; END IF;
      pos(1):=pos(1)*relative+x;
      pos(2):=pos(2)*relative+y;
      Insertion_Queue(L,pos);
   END;
END;
