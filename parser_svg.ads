WITH Math, Ada.Strings.Unbounded;
USE Math, Ada.Strings.Unbounded;

PACKAGE Parser_Svg IS
   USE Liste_Points;

   subtype Upper IS Character range 'A'..'Z';
   subtype Lower IS Character range 'a'..'z';

   --parse un fichier svg et retourne une liste de points (voir documentation)
   PROCEDURE Chargement_Bezier(Nom_Fichier,Fichier_STL: String;L: OUT Liste);
   PROCEDURE Load_Drawing(L: OUT Liste;path: Character;x,y: Float);
END;
