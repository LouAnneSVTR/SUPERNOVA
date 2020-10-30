import processing.core.PFont;
import processing.core.PImage;
import processing.core.PVector;

public class Information {

    //Police d'écriture
    private PFont police;

    //Taille du cadre blanc.
    private float cadreX, cadreY;
    private float taillePolice;

    //Constructeur
    public Information( float cadreX, float cardeY) {
        this.cadreX = cadreX;
        this.cadreY = cardeY;
        this.taillePolice = (float) ((width*1.2) / 100);
    }

    //-----------------------------------
    /** ROLE : Ecriture de l'explication par rapport à la page rendu.
     *
     * @param numeroPage int : numéro de la page actuel.
     */
    public void ecritureInformation(int numeroPage) {
        this.police = createFont("nasalization-rg.ttf", this.taillePolice);
        textFont(police);
        textAlign(LEFT, DOWN);
        fill(255);

        if (numeroPage == 1) {
            //On écrit les textes à partir de 12% de la largeur du cadre et de 30% de sa longueur.
            //Ce calcul de pourcentage permet d'adapter le texte sur différents écrans d'ordinateurs.

            text("La plupart des étoiles évoluent dans la séquence principale, ( stade principal de la vie stellaire ). \n" +
                    "Leur durée de vie dépend de leur masse et de leur taille.\n" +
                    "Ainsi, notre soleil dispose de 10 milliard d'année alors qu’une géante bleu comme Rigel seulement\n" +
                    "de 10 millions d’années.\n ", (this.cadreX*12)/100, (this.cadreY*27)/100);

            textSize((float) (this.taillePolice * 1.5));
            text("Fin de vie des étoiles\n", (this.cadreX*12)/100, (this.cadreY*52)/100);

            textSize(this.taillePolice);
            //De même ici, on écrit à partie de 60% de la largeur (pour y ) du cadre.
            text("Les étoiles entre 0,5 et 8 masse solaire ont une fin bien calme. Leur coeur se contracte, leur\n" +
                                      "enveloppe se dilate pour devenir des géantes rouges ( comme Aldebaran ). Elles libèrent alors \n" +
                                      "leur couches supérieures pendant 100 millions d'années et achèvent leur existence en une élégante \n" +
                                      "nébuleuse planétaire, illuminée par le rayonnement d’une naine blanche centrale. \n" +
                                      "Cet objet luit pendant des milliards d’années avant de s’éteindre en naine noire (hypothétique). \n" +
                                      "C'est cette fin qu'attends notre soleil...\n", (this.cadreX*12)/100, (this.cadreY*60)/100);

        } else if (numeroPage == 2) {

            textSize(this.taillePolice);
            this.police = createFont("nasalization-rg.ttf", 17);
            text("Les étoiles entre 8 et 25 masses solaires deviennent des supergéantes rouge comme Bételgeuse. \n" +
                                     "Une fois l’ensemble de leur carburant consommé, leur noyau fini par se contracter brutalement pendant\n" +
                                     "que le reste est violemment projeté dans l’espace. Ce contrebalancement de force creer alors la Supernova.\n" +
                                     "L’explosion est telle qu’elle produit plus de lumière que toutes les étoiles réunis de l’univers !\n" +
                                     "Une fois l’explosion terminé, le coeur restant se transforme en étoile à \n" +
                                     "neutrons avec une vitesse de rotation de plusieurs dizaine de tour seconde.\n" +
                                     "C’est cette fin que nous souhaitons représenter. \n" +

                                     "\nSi cette étoile à neutrons dépasse l’étoile à neutrons dépasse 3.2 masse solaire, elle\n" +
                                     "s'effondre sous sa force gravitationnel et devient un trous noir stellaire…\n" +

                                     "\n\nPour les étoiles plus massive leur mort ne permet pas à l’étoile à neutrons de\n" +
                                     "subsister, la masse étant beaucoup trop importante pour compenser la gravité,\n" +
                                     "le destin du trous noir est alors inévitable...\n", (this.cadreX*12)/100, (this.cadreY*27)/100);

        }
    }
}
