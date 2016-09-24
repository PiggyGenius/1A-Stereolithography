WITH Ada.Text_IO,Ada.Unchecked_Deallocation;
USE Ada.Text_IO;

PACKAGE BODY Liste_Generique IS
   PROCEDURE Free IS NEW Ada.Unchecked_Deallocation(Cellule,Pointeur);

   PROCEDURE Vider(L:IN OUT Liste) IS
   BEGIN
      WHILE L.Debut/=NULL LOOP
         L.Fin:=L.Debut.Suivant;
         Free(L.Debut);
         L.Debut:=L.Fin;
      END LOOP;
      L.Taille:=0;
   END;

   PROCEDURE Insertion_Tete(L:IN OUT Liste;E: Element) IS
   BEGIN
      IF L.Debut=null THEN
         L.Debut:=New Cellule'(E,null);
         L.Fin:=L.Debut;
      ELSE
         L.Debut:=new Cellule'(E,L.Debut);
      END IF;
      L.Taille:=L.taille+1;
   END;

   PROCEDURE Insertion_Queue(L:IN OUT Liste;E : Element) IS
   BEGIN
      IF L.Fin=NULL THEN
         L.Fin:=New Cellule'(E,null);
         L.Debut:=L.Fin;
      ELSE
         L.Fin.all.Suivant:=new Cellule'(E,null);
         L.Fin:=L.Fin.all.Suivant;
      END IF;
      L.taille:=L.taille+1;
   END;

   procedure Parcourir (L : Liste) is
       Courant : Pointeur;
   begin
      Courant := L.Debut;
      while Courant /= NULL loop
          Traiter(Courant.Contenu);
          Courant := Courant.Suivant;
      end loop;
   end;

   procedure Parcourir_Par_Couples(L : Liste) is
       P : Pointeur;
   begin
      P := L.Debut;
       while P/=NULL AND THEN P.all.Suivant/=NULL loop
           Traiter(P.all.contenu,P.all.Suivant.all.Contenu);
           P := P.all.Suivant;
       end loop;
   end;

   PROCEDURE Fusion(L1:IN OUT Liste;L2:IN OUT Liste) IS
      P: Pointeur := L1.Debut;
   BEGIN
      IF L1.Debut=NULL THEN 
         L1.Debut:=L2.Debut;
         RETURN;
      END IF;
      WHILE P.Suivant/=NULL LOOP NULL; END LOOP;
      P.Suivant:=L2.Debut;
   END;

   FUNCTION Taille(L: Liste) RETURN Natural IS
   BEGIN
      RETURN L.Taille;
   END;

   FUNCTION Tete(L : Liste) RETURN Element IS
   BEGIN
      IF L.Debut=NULL THEN
         RAISE CONSTRAINT_ERROR;
      END IF;
      RETURN L.Debut.Contenu;
   END;

   FUNCTION Queue(L: Liste) RETURN Element IS
   BEGIN
      IF L.Fin=NULL THEN
         RAISE CONSTRAINT_ERROR;
      END IF;
      RETURN L.Fin.Contenu;
   END;
   
   PROCEDURE Traiter(E1,E2:IN Element) IS
   BEGIN
      NULL;
   END;
END;
