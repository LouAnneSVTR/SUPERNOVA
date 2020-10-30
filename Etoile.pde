import processing.core.PVector;
import java.util.ArrayList;

public class Etoile {

    //Creation du centre de l'etoile
    private float centreX, centreY;
    private PVector centre;

    //Creation etoile
    private int nbPoint;
    private PVector[] tabPoint;
    private float rayon, stepAngle;

    //Remplissage etoile de particules
    private int nbParticule;
    private ArrayList<ParticuleEtoile> listeParticuleEtoile;
    int c1, c2;

    //Diminution rayon etoile
    boolean dimDebut = false;

    //Constructeur
    public Etoile(int nb) {

        //Creation du centre de l'etoile
        this.centreX = width / 2;
        this.centreY = height / 2;
        this.centre = new PVector(centreX, centreY);

        //Element du cercle
        this.rayon = (height * 15) / 100;
        this.nbPoint = nb;
        this.tabPoint = new PVector[this.nbPoint];
        this.stepAngle = 2 * PI / nbPoint;

        //Remplissage de particule
        /* Initialisation de listeParticuleEtoile.
         * Sert à remplir de cercle l'étoile pour donner une impression réaliste de mouvement.
         */
        this.nbParticule = (int) (10000*this.rayon/80); //Nombres de cercles présents dans l'étoile
        this.listeParticuleEtoile = new ArrayList<ParticuleEtoile>();
    }


    //*********************************** DESSIN ETOILE **********************************************
    /** ROLE : Calcul les coordonnées polaires de tous les points du cercle.
     * @return PVector
     */
    private PVector pol2Cart(PVector centre, float rayon, float angle) {
        return new PVector(centre.x + rayon * cos(angle), centre.y + rayon * sin(angle));
    }

    //-----------------------------------
    /** ROLE : Dessine tous les nbPoint du cercle qui servira de base à notre étoile.
     *  Remplis tabPointOrigin de tous les points du cercles pour les vertex. */
    public void createCircle() {
        for (int i = 0; i < this.nbPoint; i++) {
            PVector p = pol2Cart(this.centre, this.rayon, this.stepAngle * i);
            point(p.x, p.y);
            this.tabPoint[i] = p;
        }
    }

    //-----------------------------------
    /** ROLE : Relis tous les points pour obtenir une forme fermé, un cercle. */
    public void drawCurve() {
        PVector p, psuiv;
        fill(176,224,200);//bleu poudre
        beginShape();

        for (int i = 0; i < this.nbPoint - 1; ++i) {
            p = tabPoint[i];
            psuiv = tabPoint[i + 1];

            curveVertex(p.x, p.y);
            curveVertex(psuiv.x, psuiv.y);
        }
        endShape();
    }

    //**************************************** APPARENCE ********************************************
    /** ROLE : Creation de tous les centres des particules qui remplirons notre etoile.
     *  Le but est d'avoir une apparence qui s'approche du réalisme.
     *  Remplis également la listeApparence qui servira au dessin des cercles.
     *  Gère l'interpolation des couleurs. */
    public void initPart() {
        for (int i = 0; i < this.nbParticule; i++) {
            //Creation des particules
            this.listeParticuleEtoile.add(new ParticuleEtoile(this.rayon, this.centre));
        }
    }

    //-----------------------------------
    /** ROLE : Verifie si les particules no'ont pas atteint le bord de l'étoile.
     *  Si c'est la cas remove + création d'une nouvelle particule.
     *  Sinon, interpolation des particules + update.
     *
     *  PRECONDITION : La liste doit être initalisé.
     */
    public void drawInterieur() {

        for (int i = 0; i < this.listeParticuleEtoile.size(); i++) {

            ParticuleEtoile p = this.listeParticuleEtoile.get(i);

            if (p.verifLimite(this.rayon)) {
                this.listeParticuleEtoile.remove(p); //Supprime les particules en dehors du rayon de l'etoile.
                this.listeParticuleEtoile.add(new ParticuleEtoile(this.rayon, this.centre)); //Re-creer de nouvelles particules.

            } else {
                p.drawPart(); //Dessine les particules.
                p.updatePart(); //Fait vivre les particules.
            }
        }
    }


    //************************************* DIMINUTION ETOILE *******************************************
    /** ROLE : Diminue la taille de l'étoile à partir de 20 secondes après le démarage de la Supernova.
     * Augmentation de l'accélération au fur et à mesure du bouclage du draw. */
    public void diminutionRayon(Float acceleration){
        if (this.rayon > 10){
            float diminution = (float) (0.5+acceleration);
            this.rayon -= (diminution); //Diminue rayon de notre étoile.
            this.dimZoneParticule(diminution); //Diminution des rayons limites des particules.
        }
    }

    //-------------------------------
    /** ROLE : Diminue pour toutes les particules leur zones de vie.
     *
     * PRECONDITION : Liste doit être initialisé.
     */
    private void dimZoneParticule(float coeff_acceleration){
            for (int i = 0 ; i < this.listeParticuleEtoile.size() ; ++i) {
                ParticuleEtoile p = this.listeParticuleEtoile.get(i);
                p.changementVelocite(coeff_acceleration); //Adapte la vélocité des particules par rapport à la diminution du rayon.
            }
    }

    //-------------------------------
    /** ROLE : Sert de condition d'arret, test si l'étoile à un rayon de 10 pixel.
     *
     * PRECONDITION : Le rayon doit être intilialisé.
     * @return boolean
     */
    public boolean conditionArret(){
        return this.rayon <= 10;
    }
}
