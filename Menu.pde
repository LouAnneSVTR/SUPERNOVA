import processing.core.PFont;
import processing.core.PImage;
import processing.core.PVector;
import java.util.ArrayList;

public class Menu {

    private Supernova supernova;

    public Information information;

    //Ecart des boutons centraux.
    private float ecartCentreX;
    private float ecartCentreY;
    private float ecartTexte;

    //taille du grand cadre du menu & information.
    private float tailleCadreX, tailleCadreY;

    //Eccart du bouton retour.
    private float ecartBoutonRetourArriereX;
    private float ecartBoutonRetourArriereY;

    //Centre des objets présents dans le menu.
    private PVector centreEcran;
    private PVector centreCadre;
    private PVector centreBoutonSupernova;
    private PVector centreBoutonInformation;
    private PVector centreBoutonRetourArriere;
    private PVector centreBoutonRetourMenu;
    private PVector centreBoutonSuivant;
    private PVector centreBoutonPrecedent;

    //Initialisations de tous les boutons du menu.
    private BoutonSupernova boutonSupernova;
    private BoutonInformation boutonInformation;
    private BoutonRetourInformation boutonRetourArriere;
    private BoutonRetourSupernova boutonRetourMenu;
    private BoutonSuivant boutonSuivant;
    private BoutonSuivant boutonPrecedent;

    //Numéro de la page d'information.
    private int numeroPageInformation;

    //Taille police
    private float taillePolice;

    //Police d'écriture du titre.
    private PFont police;

    private PImage[] tabSupernova;

    //Temps au lancement de supernova.
    private int temps;

    //Constructeur
    public Menu() {

        this.supernova                  = new Supernova();
        this.supernova.intialisationSupernova();

        this.ecartCentreX               = (width * (float) 12.5) / 100;
        this.ecartCentreY               = (height * 15) / 100;
        this.ecartTexte                 = (height / 2 * 38) / 100;

        this.tailleCadreX               = (width * 90) / 100; //Taille du cadre
        this.tailleCadreY               = (height * 90) / 100;

        this.information                = new Information(this.tailleCadreX, this.tailleCadreY); //Construction de l'objet Information.

        //Ecart entre le cadre et le bouton retour arriere (Bouton qui depuis Information page 1 ou page 2 permet de retourner au menu principal ).
        this.ecartBoutonRetourArriereX  = (this.tailleCadreX * (float) 4.7) / 100;
        this.ecartBoutonRetourArriereY  = (this.tailleCadreY * 8) / 100;

        this.centreEcran                = new PVector(width / 2, height / 2); //Centre de l'écran.
        this.centreCadre                = new PVector(width / 2, height / 2); //Centre du cadre du menu.


        //Création des centres de tous les boutons.
        this.centreBoutonSupernova      = new PVector(  this.centreEcran.x + this.ecartCentreX, this.centreEcran.y + this.ecartCentreY);
        this.centreBoutonInformation    = new PVector(  this.centreEcran.x - this.ecartCentreX, this.centreEcran.y + this.ecartCentreY);
        this.centreBoutonRetourArriere  = new PVector(  this.centreEcran.x - (this.tailleCadreX / 2 - this.ecartBoutonRetourArriereX),
                                                        this.centreEcran.y + (this.tailleCadreY / 2 - this.ecartBoutonRetourArriereY));
        //Centre du bouton permettant de revenir au menu dès la fin de la Supernova.
        this.centreBoutonRetourMenu     = new PVector(  this.centreEcran.x + (this.tailleCadreX / 2 - this.ecartBoutonRetourArriereX),
                                                        this.centreEcran.y + (this.tailleCadreY / 2 - this.ecartBoutonRetourArriereY));
        this.centreBoutonSuivant        = new PVector(  this.centreEcran.x + (this.tailleCadreX / 2 - this.ecartBoutonRetourArriereX),
                                                        this.centreEcran.y - (this.tailleCadreY / 2 - this.ecartBoutonRetourArriereY));
        this.centreBoutonPrecedent      = new PVector(  this.centreEcran.x - (this.tailleCadreX / 2 - this.ecartBoutonRetourArriereX),
                                                        this.centreEcran.y - (this.tailleCadreY / 2 - this.ecartBoutonRetourArriereY));

        //Création des tous les boutons.
        this.boutonSupernova            = new BoutonSupernova(this.centreBoutonSupernova.x, this.centreBoutonSupernova.y, 175, 85, this.supernova);
        this.boutonInformation          = new BoutonInformation(this.centreBoutonInformation.x, this.centreBoutonInformation.y, 175, 85, this.information);
        this.boutonRetourArriere        = new BoutonRetourInformation(this.centreBoutonRetourArriere.x, this.centreBoutonRetourArriere.y, 75, 75 );
        this.boutonRetourMenu           = new BoutonRetourSupernova(this.centreBoutonRetourMenu.x, this.centreBoutonRetourMenu.y, 75, 75);
        this.boutonSuivant              = new BoutonSuivant(this.centreBoutonSuivant.x, this.centreBoutonSuivant.y, 75, 75, "SUIV" );
        this.boutonPrecedent            = new BoutonSuivant(centreBoutonPrecedent.x, centreBoutonPrecedent.y, 75, 75, "PREC" );

        this.numeroPageInformation      = 1; //Numero de page d'information.

        this.taillePolice = (width * 10) / 100;

        this.temps                      = 0;
    }

    public int getNumeroPageInformation() {
        return this.numeroPageInformation;
    }

    //****************************************** DRAW ******************************************
    /** ROLE: dessine le menu principal. */
    public void drawMenuPrincipal() {

        //Dessin du fond étoilé dans le but d'avoir toujours le meme fond.
        this.supernova.getFond().drawEtoiles();

        //Parametre de dessin du cadre blanc.
        rectMode(CENTER);
        noFill();
        strokeWeight(2);
        stroke(255);
        rect(centreCadre.x, centreCadre.y, this.tailleCadreX, this.tailleCadreY);
        fill(255);

        this.drawTitre(); //Ecris : "SUPERNOVA".

        //Dessine les 2 boutons du menu.
        this.boutonSupernova.drawBouton(); //Bouton bleu.
        this.boutonSupernova.effetSouri();
        this.boutonInformation.drawBouton(); //Bouton rouge.
        this.boutonInformation.effetSouri();
    }

    //------------------------------------------
    /** ROLE: Dessine Les pages informations. */
    public void drawInformation() {

        //Dessin du fond étoilé dans le but d'avoir toujours le meme fond.
        this.supernova.getFond().drawEtoiles();

        //Parametre de dessin du cadre blanc.
        rectMode(CENTER);
        noFill();
        strokeWeight(2);
        stroke(255);
        rect(centreCadre.x, centreCadre.y, this.tailleCadreX, this.tailleCadreY); //Dessin rectangle.

        this.boutonRetourArriere.drawBouton(); //Bouton Vert.
        this.boutonRetourArriere.effetSouri();

        //Affiche le bouton "suivant" jaune de la page 1.
        if (this.numeroPageInformation == 1) {
            this.boutonSuivant.drawBouton();
            this.boutonSuivant.effetSouri();

        //Affiche le bouton "précedent" jaune de la page 2.
        } else if (this.numeroPageInformation == 2){
            this.boutonPrecedent.drawBouton();
            this.boutonPrecedent.effetSouri();
            //Animation giff

        }

        //Permet d'ecrire le texte de la page information.
        this.boutonInformation.lancementBouton();
    }

    //------------------------------------------
    /** ROLE : Dessine le bouton permettant de retourner au menu à la fin de la Supernova.
     * Nous l'avons appellé Menu de fin */
    public void drawBoutonFin() {
        this.boutonRetourMenu.drawBouton(); //Bouton blanc.
        this.boutonRetourMenu.effetSouri();
    }

    //------------------------------------------
    /** ROLE : Dessine le titre du programme "SUPERNOVA". */
    public void drawTitre() {
        this.police = createFont("BLADRMF_.TTF", 120); //Police de caractère.
        textFont(police);
        textAlign(CENTER, CENTER);
        textSize(this.taillePolice);
        text("supernova", this.centreEcran.x, this.centreEcran.y - this.ecartTexte); //Ecris Supernova
    }


    //******************************* BOUTON SUPERNOVA *************************************
    /** ROLE : Verifie si le curseur est bien sur le bouton.
     *
     * @return boolean : "true" si le curseur est dessus. */
    public boolean verificationBoutonSuperNova() {
        return this.boutonSupernova.verificationBouton();
    }

    //-----------------------------------
    /** ROLE : Lance le programme approprié du bouton dès que l'action est terminé.*/
    public void lancementBoutonSuperNova() {
        if (this.boutonSupernova.lancementBouton()) { //Verifie si l'animation du bouton est terminé.
            this.supernova.setTempsMemoire(this.temps);
        }
    }

    //******************************* BOUTON INFORMATION *************************************
    /**ROLE: Verifie si le curseur est bien sur le bouton.
     *
     * @return boolean : "true" si le curseur est dessus.
     */
    public boolean verificationBoutonInformation() {
        return this.boutonInformation.verificationBouton();
    }

    //-----------------------------------
    /** ROLE : Dès que l'animation du bouton est terminé, lance le menu approprié.
     *
     * @return boolean : "true" quand c'est fini.
     */
    public boolean lancementBoutonInformation() {
        if (this.boutonInformation.lancementBouton()) { //Verifie si l'animation du bouton est terminé.
            this.drawInformation();
            return true;
        }
        return false;
    }

    //******************************* BOUTON RETOUR INFORMATION *************************************
    /** ROLE: Verifie si le curseur est bien sur le bouton.
     *
     * @return boolean : "true" si le curseur est dessus.
     */
    public boolean verificationBoutonRetourInformation() {
        return this.boutonRetourArriere.verificationBouton();
    }

    //-----------------------------------
    /** ROLE : réinitialise les lancement des effets des boutons information et bouton retour en arrière.
     *
     * @return boolean
     */
    public boolean lancementBoutonRetourInformation() {

        this.boutonRetourArriere.setLance(false); //Reinitalise l'animation du boutonRetourArriere.
        this.boutonInformation.reinitialiserPage(); //Reinitialise la page à 1 dans le bouton.
        this.reinitialiserPage(); //Reinitialise le compteur de page à 1 dans le menu.
        this.boutonInformation.setLancement(false); //Reinitialise l'animation du bouton rouge.
        return this.boutonRetourArriere.lancementBouton();
    }

    //-----------------------------------
    /** ROLE : Réinitialise le lancement de l'effet du bouton d'information. */
    public void reinitialisationBoutonInformation() {
        this.boutonInformation.setLancement(false);
    }


    //******************************* BOUTON RETOUR SUPERNOVA *************************************
    /** ROLE : Vérifie si le curseur est bien sur le bouton.
     *
     * @return boolean : "true" si le curseur est dessus.
     */
    public boolean verificationBoutonRetourSupernova() {
        return this.boutonRetourMenu.verificationBouton();
    }


    //-----------------------------------
    /** ROLE : Deque l'animation du bouton est terminé, lance le menu approprié.
     *
     * @return boolean : "true" quand c'est fini.
     */
    public boolean lancementRetourSupernova() {
        this.boutonSupernova.setLance(false); //Reinitalise l'animation du boutonSupernova.
        this.boutonRetourMenu.setLance(false); //Reinitalise l'animation du boutonRetourMenu.
        if (this.boutonRetourMenu.lancementBouton()) { //Verifie si l'animation du bouton est terminé.
            this.restart(); //Redemarre du début la supernova.
            return this.boutonRetourMenu.lancementBouton();
        }
        return this.boutonRetourMenu.lancementBouton();
    }

    //******************************* BOUTON INFORMATION SUIVANT *************************************
    /** ROLE : Verifie si le curseur est bien sur le bouton.
     *
     * @return boolean : "true" si le curseur est dessus.
     */
    public boolean verificationBoutonSuivant() {
        return this.boutonSuivant.verificationBouton();
    }


    //-----------------------------------
    /** ROLE : Deque l'animation du bouton est terminé, lance le menu approprié.
     *
     * @return boolean : "true" quand c'est fini.
     */
    public boolean lancementBoutonSuivant() {
        this.boutonSuivant.setLance(false); //Reinitalise l'animation du boutonSuivant.
        if (this.boutonSuivant.lancementBouton()) {  //Verifie si l'animation du bouton est terminé.
            this.augmenterPage(); //Augmente le numéro de page dans menu.
            this.boutonInformation.augementerPage(); //Augmente le numéro de page dans information.
            return true;
        }
        return false;
    }

    //******************************* BOUTON INFORMATION PRECEDENT *************************************
    /** ROLE : Verifie si le curseur est bien sur le bouton.
     *
     *  @return boolean : "true" si le curseur est dessus.
     */
    public boolean verificationBoutonPrecedent() {
        return this.boutonPrecedent.verificationBouton();
    }

    //-----------------------------------
    /** ROLE : Deque l'animation du bouton est terminé, lance le menu approprié.
     *
     *  @return boolean : "true" quand le lancement est fini.
     */
    public boolean lancementBoutonPrecedent() {
        this.boutonPrecedent.setLance(false); //Reinitalise l'animation du boutonPrecedent..
        if (this.boutonPrecedent.lancementBouton()) {  //Verifie si l'animation du bouton est terminé.
            this.diminuerPage(); //Diminue la page dans menu.
            this.boutonInformation.diminuerPage(); //Diminue la page dans information.
            return true;
        }
        return false;
    }

    //-----------------------------------
    /** ROLE : Augmente la page d'un. Si dépasse limite maximum page, ce n'est pas incrémenté. */
    private void augmenterPage() {
        if (this.numeroPageInformation < 2) { //Tant que ça depasse pas 1.
            this.numeroPageInformation++;
        }
    }

    //-----------------------------------
    /** ROLE : Diminue la page d'un. Si dépasse limite minimum page, ce n'est pas decrémenté. */
    private void diminuerPage() {
        if (this.numeroPageInformation >1) { //Tant que c'est strictement superieur à 1.
            this.numeroPageInformation--;
        }
    }

    //-----------------------------------
    /** ROLE : Reinitialise le début de page. */
    private void reinitialiserPage() {
        this.numeroPageInformation = 1;
    }


    //******************************* REDEMMARAGE SUPERNOVA *************************************
    /** ROLE : Vérifie si le programme est fini ou non.
     *
     * @return boolean
     */
    public boolean finProgramme() {
        return this.supernova.finProgramme();
    }

    //-----------------------------------
    /** ROLE : Re-start la supernova, recréer une nouvelle supernova. */
    private void restart() {
        this.supernova = new Supernova(); //Nouvelle supernova.
        this.supernova.intialisationSupernova(); //Initialise la nouvelle supernova.
        this.boutonSupernova.restart(this.supernova); //Envoie la nouvelle supernova dans le boutonSupernova.+-
    }

    //-----------------------------------
    /** ROLE : Nouveau temps au lancement de supernova. */
    public void tempsLancementSupernova() {
        this.temps = millis();
    }
}
