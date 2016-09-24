with Math,Liste_Generique;
use Math;

package STL is
   type Facette is record
      P1, P2, P3 : Vecteur(1..3);
   end record;

   Xmin,Ymin : Float;
   
   --package Liste_Points is new Liste_Generique(Point2D);
   package Liste_Facettes is new Liste_Generique(Facette);

   --prend une liste de segments et cree l'objet 3d par rotations
   procedure Creation(Segments : in out Liste_Points.Liste ; --Liste_Points.LIste
                      Facettes :    out Liste_Facettes.Liste);

   --sauvegarde le fichier stl
   procedure Sauvegarder(Nom_Fichier : String ;
                         Facettes : Liste_Facettes.Liste);
   PROCEDURE Header(Nom_Fichier: String);
   PROCEDURE Footer(Nom_Fichier: String);
end;
