WITH Ada.Text_IO,Ada.Numerics,Ada.Numerics.Elementary_Functions,Liste_Generique,Ada.Float_Text_IO;
USE Ada.Text_IO,Ada.Numerics,Ada.Numerics.Elementary_Functions,Ada.Float_Text_IO;

PACKAGE BODY STL IS
   File : File_Type;
   PROCEDURE Creation(Segments:IN OUT Liste_Points.Liste;Facettes:OUT Liste_Facettes.Liste) IS
      PROCEDURE Cherche(E:IN OUT Point2D) IS
      BEGIN
         IF E(1)<Xmin THEN
            Xmin:=E(1);
         END IF;
         IF E(2)<Ymin THEN
               Ymin := E(2);
         END IF;
      END;

      PROCEDURE Translate(E:IN OUT Point2D)IS
      BEGIN
         E(1):=E(1)-Xmin;
         E(2):=E(2)-Ymin;
      END;

      PROCEDURE Facette(E1,E2: Point2D) IS
         P1, P2, P3,P4 : Vecteur(1..3); 
         angle: Float;
         N: constant Natural := 200;
      BEGIN
         P1:=(E1(2),E1(1),0.0);
         P2:=(E2(2),E2(1),0.0);
         FOR i IN 1..200 LOOP
            angle := Float(i)*(360.0/200.0);
            P3(1) := E1(2)*cos(Cycle => 360.0,x => angle);
            P3(2) := E1(1);
            P3(3) := E1(2)*sin(Cycle => 360.0,x => angle);
            Liste_Facettes.Insertion_Queue(Facettes,(P1,P2,P3));
            P4(1) := E2(2)*cos(Cycle => 360.0,x => angle);
            P4(2) := E2(1);
            P4(3) := E2(2)*sin(Cycle => 360.0,x => angle);
            Liste_Facettes.Insertion_Queue(Facettes,(P2,P4,P3));
            P1:=P3;P2:=P4;  
         END LOOP;
      END;

      PROCEDURE RunIt(E1,E2:IN Point2D) IS
      BEGIN
         Put(E1(1),exp=>0,aft=>0);Put(",");Put(E1(2),exp=>0,aft=>0);New_Line;
         Put(E2(1),exp=>0,aft=>0);Put(",");Put(E2(2),exp=>0,aft=>0);New_Line;New_Line;
      END;
      PROCEDURE Run IS NEW Liste_Points.Parcourir_Par_Couples(RunIt);

      PROCEDURE ChercheTout IS NEW Liste_Points.Parcourir(Cherche);
      PROCEDURE TranslateTout IS NEW Liste_Points.Parcourir(Translate);
      PROCEDURE FacetteTout IS NEW Liste_Points.Parcourir_Par_Couples(Facette);
   BEGIN
      IF Liste_Points.Taille(Segments)=0 THEN RETURN; END IF;
      Xmin := Liste_Points.Tete(Segments)(1);
      Ymin := Liste_Points.Tete(Segments)(2);
      ChercheTout(Segments);
      TranslateTout(Segments);
      Run(Segments);
      FacetteTout(Segments);
   END;

   PROCEDURE Header(Nom_Fichier: String) IS
   BEGIN
      Create(File,OUT_FILE,Nom_Fichier);
      Put(File,"solid ");
      Put_Line(File,Nom_Fichier);
   END;
   PROCEDURE Footer(Nom_Fichier: String) IS
   BEGIN
      Put(File,"endsolid ");
      Put(File,Nom_Fichier);
      Close(File);
   END;

   PROCEDURE Sauvegarder(Nom_Fichier: String;Facettes: Liste_Facettes.Liste) IS
      PROCEDURE Ecrire(E:IN OUT Facette) IS
      BEGIN
         Put_Line(File,"facet");
         Put_Line(File,"outer loop");
         Put(File,"vertex ");
         FOR k IN 1..3 LOOP
            Put(File," ");Put(File,E.P1(k),exp=>0);
            --Put(File," ");Put(File,E.P1(k));
         END LOOP;
         New_Line(File);Put(File,"vertex ");
         FOR k IN 1..3 LOOP
            Put(File," ");Put(File,E.P2(k),exp=>0);
            --Put(File," ");Put(File,E.P2(k));
         END LOOP;
         New_Line(File);
         Put(File,"vertex ");
         FOR k in 1..3 loop
            put(file," ");put(file,E.p3(k),exp=>0);
            --put(file," ");put(file,e.p3(k));
         END LOOP;
         New_Line(File);
         Put_Line(File,"endloop");
         Put_Line(File,"endfacet");
      END;

   PROCEDURE EcrireTout IS NEW Liste_Facettes.Parcourir(Ecrire);
   BEGIN
      IF Liste_Facettes.Taille(Facettes)=0 THEN RETURN; END IF;
       EcrireTout(Facettes);
   END;
END;
