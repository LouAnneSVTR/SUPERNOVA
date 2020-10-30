import processing.core.PVector;


public class ElementNuage {

    private PVector positionOrigine;

    private float taille; //Taille des éléments.

    private float angle; //Angle de direction.

    private boolean finAcceleration;  //Fin de l'acceleration.

    private int rD,gD,bD; //Couleur de l'élément.

    private PVector velocite;  //Velocité de l'élément.

    //Compteur de distance.
    //PLus ce compteur est élevé, plus l'élément parcours une grande distance.
    private float cpt;

    private boolean elementZero; //Verification si c'est un élément zero.
    
    //-------------------------------------------------
    //Constructeur 1 : construit l'élément 0 du nuage.
    public ElementNuage(float posX, float posY) {
        this.positionOrigine = new PVector(posX, posY);

        this.taille = (float) 1;

        //Permet d'avoir un direction aléatoire fluide.
        this.angle = noise(0, 2) * PI;

        this.finAcceleration = false;

        this.rD = (int)random(255);
        this.gD = (int)random(255);
        this.bD = (int)random(255);

        //Permet de faire avancer l'élément 0 avec une vélocité.
        this.velocite =  new PVector(cos(angle), sin(angle));

        this.cpt = 0;

        this.elementZero = true; //Pour vérifier si l'élément est un élément 0. ( ce dernier est unique ! ).
    }

    //Constructeur 2 : Les enfants de l'élément zéro (sans prise en compte des angles).
    //Ainsi, les éléments crees par l'élément 0 vont dans toutes les direction ( 2Pi ).
    public ElementNuage(PVector pos, int r, int g, int b) {
        this.positionOrigine = pos; //"pos" représente la position ou l'élément père est arrété.

        this.taille = (float) 1;

        this.angle = angle + random((float)0,(float)2) * PI;

        this.finAcceleration = false;

        //Attribution des couleurs de l'élément.
        this.rD = r;
        this.gD = g;
        this.bD = b;

        //Perment de donner une vélocité différente pour chaque particule.
        float multVel = random((float) 0.1, 3);
        this.velocite =  new PVector(cos(angle)*multVel, sin(angle)*multVel);

        this.cpt = 0;

        this.elementZero = false;
    }

    //Constructeur 3 : Enfants des éléments normaux (avec angle).
    //Ces éléments suivent la direction de leur père avec un léger changement (+ ou - 0.15).
    public ElementNuage(PVector pos, int r, int g, int b, float angle) {
        this.positionOrigine = pos; //"pos" représente la position ou l'élément père est arrété.

        this.taille = (float) 1;

        //Permet d'avoir un direction aléatoire.
        //Adittionne l'angle du père à = ou - 15 degré.
        // Permet d'advoir des déplacements fluides avec de faibles changements de direction le tout pour donner une impression de "file".
        this.angle = angle + random((float)-0.15,(float) 0.15) * PI % (2*PI);

        this.finAcceleration = false;

        //Attribution des couleurs de l'élément.
        this.rD = r;
        this.gD = g;
        this.bD = b;

        //Perment de donner une vélocité différente pour chaque particule.
        float multVel = random((float) 0.1, 3);
        this.velocite =  new PVector(cos(this.angle)*multVel, sin(this.angle)*multVel);

        this.cpt = 0;

        this.elementZero = false;
    }
    


    //*********************************************** DRAW ***********************************************
    /** ROLE : Dessine l'élément. */
    public void drawElement() {
        fill(this.rD, this.gD, this.bD, 150);
        circle(positionOrigine.x, positionOrigine.y, taille);
    }

    //***************************************** MOUVEMENT ELEMENTS *****************************************
    /** ROLE : Update l'élément */
    public void update() {
        if (this.cpt < 2) { //Test si le compteur de distance est inférieur à 2.
            vitesse(); //Augmente la vitesse. → déplacement.
        this.cpt++; //Augmentation  du compteur.
            return;
        }
        this.finAcceleration = true;//Affecter "true" permert de terminer l'accélération.
        return;
    }

    //-------------------------------------------------
    /** ROLE : Augmentation de la vitesse. */
    private void vitesse() {
        positionOrigine.add(velocite);
    }

    //-------------------------------------------------
    /** ROLE : vérifie si l'acceleration est terminé.
     *
     * @return boolean : acceleration ok ou pas.
     */
    public boolean isfinAcceleration() {
        return finAcceleration;
    }


    //************************************** CREATION NOUVEL ELEMENTS **************************************
    /** ROLE : Creation d'un nouvel élément par "this" en fonction du constructeur appellé (élément zero ou pas).
     *
     * @return ElementNuage : Nouveau élément.
     */
    public ElementNuage nouvPoint() {
        if(this.elementZero){ //si c'est une particule zero, génère une particule spéciale.
            return new ElementNuage(new PVector(positionOrigine.x, positionOrigine.y), (int) random(this.rD - 100, this.rD + 100), (int) random(this.gD - 100, this.gD + 100),  (int) random(this.bD - 100, this.bD + 100));
        } else { //sinpn particule normale.
            return new ElementNuage(new PVector(positionOrigine.x , positionOrigine.y), this.rD, this.gD, this.bD, this.angle);
        }
    }

    //-------------------------------------------------
    /** ROLE : Vérifie si "this" est un élément "zero" ( cad s'il est la particule d'origine ).
     *
     * @return boolean
     */
    public boolean isElementZero() {
        return this.elementZero;
    }
}
