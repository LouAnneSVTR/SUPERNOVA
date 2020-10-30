import processing.core.PVector;
import java.util.ArrayList;

public class Supernova {
    private ArrierePlan fond;

    private Etoile etoile;
    private boolean evennementEtoile;
    private float accelerationEtoile;

    private Explosion explosion;
    private boolean evennementExplosion;

    private Nuage nuage;
    private boolean evennementNuage;

    private boolean finProgramme;

    private int temps, tempsMemoire;

    //Constructeur
    public Supernova() {
        this.fond = new ArrierePlan(1200);

        this.etoile = new Etoile(5000);
        this.evennementEtoile = false;
        this.accelerationEtoile = 0;

        this.explosion = new Explosion(10000);
        this.evennementExplosion = false;

        this.nuage = new Nuage(300);
        this.evennementNuage = false;

        this.finProgramme = false;
        this.temps = millis();
        this.tempsMemoire = 0;

    }

    //************************************** INITIALISATION ***********************************
    /** ROLE : Initialisation toutes les classes de la Supernova */
    public void intialisationSupernova() {

        //>>>>>>>>>>>>>>>> Initialisation de l'arriere plan
        this.fond.initEtoiles();
        this.fond.drawEtoiles();

        //>>>>>>>>>>>>>>>> Initialisation de l'etoile
        this.initialisationEtoile();

        //>>>>>>>>>>>>>>>> Initialisation de l'Explosion
        this.explosion.initialisationExplosion();

    }

    //------------------------------------
    /** ROLE : Initialisation de tous les attributs de l'objet Etoile */
    private void initialisationEtoile() {
        this.etoile.initPart();

        //Creation du cercle
        this.etoile.createCircle();
        this.evennementEtoile = true;
    }


    //***************************************** LANCEMENT SUPERNOVA **************************************
    /** ROLE : Execution et dessin des elements de la Supernova
     * Quand l'un est terminé, l'autre passe à "true" et se lance */
    public void lancementSupernova() {

        //>>>>>>>>>>>>>>>> Lancement de l'arriere plans
        this.fond.drawEtoiles();

        //>>>>>>>>>>>>>>>> Lancement de l'etoile
        this.lancementEtoile();

        //>>>>>>>>>>>>>>>> Lancement de l'explosion
        this.lancementExplosion();

        //>>>>>>>>>>>>>>>> Lancement du nuage
        this.lancementNuage();
    }


    //**************************************** LANCEMENT ETOILE *************************************
    /** ROLE : Creation et dessin du cercle
     *  dessin et mouvement des partricules
     *  diminue le rayon de l'objet au bout de 20 secondes
     *  lance l'explosion en rendant evennementExplosion à "true". */
    private void lancementEtoile() {

        if (this.evennementEtoile) {

            this.temps = this.calculeTemps(tempsMemoire);
            this.etoile.createCircle();

            //Relie chaque point pour former la sphère
            this.etoile.drawCurve();

            //Dessine des points random sur l'etoile avec interpolation de couleurs
            this.etoile.drawInterieur();

            //EVENNEMENT  0: Diminution Etoile + zone des particules
            if (this.temps > 20000) {
                this.etoile.diminutionRayon(this.accelerationEtoile);
                this.accelerationEtoile += 0.07;

            }
            if (this.etoile.conditionArret()) {
                this.tempsMemoire = 0;
                this.evennementEtoile = false;
                this.evennementExplosion = true;
            }
        }
    }

    //************************************ LANCEMENT EXPLOSION *********************************
    /** ROLE : Si Etoile est correctement executé, dessin de l'explosion et du flash
     *  lance le nuage en rendant evennementNuage à "true". */
    private void lancementExplosion() {

        if (this.evennementExplosion) {

            this.explosion.drawExplosion();
            this.fond.flash(15);

            if (this.explosion.conditionLancement()) {
                this.evennementNuage = true;
            }

            if (this.explosion.conditionArret()) {
                this.evennementExplosion = false;
            }
        }
    }

    //************************************** LANCEMENT NUAGE ***********************************
    /** ROLE : Si execution de l'explosion faite, dessin des particules
    *  Si le nombre de particule est inférieur à 150, fin de la supernova. */
    private void lancementNuage() {

        if (this.evennementNuage){
            if (this.nuage.updateParticules()) {
                this.nuage.creationParticule();
            }
        }
        if(this.nuage.conditionArret()) {
            this.finProgramme = true;
        }
    }

    //*************************************** FIN PROGRAMME ************************************
    /** ROLE : Renvoie true ou false si la condition d'arret du nuage est respecté ou non.
     *  Permet la gestion du bouton retour menu.
     *  @return boolean
     */
    public boolean finProgramme() {
        return this.nuage.conditionArret();
    }


    //------------------------------------
    /** ROLE : Permet l'affichage du fond et sa recuperation dans menu.
     *  @return ArrierePlan
     */
    public ArrierePlan getFond() {
        return this.fond;
    }


    //------------------------------------
    /** ROLE : Calcul le temps écoulé entre le debut de la Supernova et l'instant actuel (millis()).
     *  Permet de controler le lancement de la supernova (diminition de l'étoile).
     *
     *  @param tempsDeclanchement int : Représente l'heure en milliseconde ou le BoutonSupernova à été enclanché.
     *  @return int
     */
    public int calculeTemps(int tempsDeclanchement) {
        return millis() - tempsDeclanchement;
    }


    //------------------------------------
    /** ROLE : Réinitialise le temps en mémoire
     *  Permet de déclancher la Supernova ( au bout de 20 secondes ) autant de fois que l'on appuis sur le bouton play
     *  Sans cette fonction, quand il y re-activation du bouton play, la supernova se déclenche directement sans temps d'attente.
     *
     *  @param temps int : Temps prends la valeur de l'heure en milliseconde ou le BoutonSupernova à été enclanché.
     */
    public void setTempsMemoire(int temps) {
        this.tempsMemoire = temps;
    }


}//FIN CLASSE SUPERNOVA
