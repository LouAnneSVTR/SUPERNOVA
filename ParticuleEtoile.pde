import processing.core.PVector;

public class ParticuleEtoile {

    private float rayonPart, rayonLimite, limiteTemps; //Rayon limite correspond au rayon de l'etoile qui est la surface a ne pas dépasser pour les particules
    private int dureeVie, naissance;
    private PVector centreEtoile, centrePart, velocite;
    private boolean update = true;

    //Couleur
    private int c1, c2, c3, c4;
    private float alpha; // Pour l'opacité

    //-------------------------------------------------
    public ParticuleEtoile(float rayonEtoile, PVector centreEtoile){
        this.rayonLimite  = rayonEtoile;
        this.centreEtoile = centreEtoile;
        this.centrePart   = new PVector();
        this.limiteTemps = random(20000);

        //Vie particule
        this.rayonPart    = 2;
        this.dureeVie     = 0;
        this.naissance    = millis();

        //Couleur des particules
        this.c1 = color(25,25,112); //Bleu nuit
        this.c2 = color(70,130,180); //Bleu acier
        this.c3 = color(100,149,237); //Bleu roi
        this.c4 = color(176,196,222); //Bleu acier clair

        this.alpha = 255;

        //Creation des particules
        createCentre();

        //Mouvement part
        float r = random((float)0.01, (float)0.5);
        this.velocite = pol2Cart(new PVector(0,0),r, random(-PI/2,PI/2)); //Add eric
        //this.velocite.normalize();
    }


    //*************************************** INTERPOLATION *********************************************
    /** ROLE : Interpolation simple
     *
     * @param x float : Variable entre 0 et 1, sert à fluidifier l'interpolation.
     * @param a float : Valeur "a" à inteporler.
     * @param b float : Valeur "b" à inteporler.
     *
     * @return float
     */
    private float interpol(float x, float a, float b) {
        return (b - a) * x + a;
    }

    //--------------------------------------------
    /** ROLE : Interpolation 2 couleurs.
     * Appelle interpolSimple pour red, green et blue.
     *
     * @param x  float : Variable entre 0 et 1, sert à fluidifier l'interpolation.
     * @param c1 float : Couleur "c1" à inteporler pour chaque valeurs rgb.
     * @param c2 float : Couleur "c2" à inteporler pour chaque valeurs rgb.
     *
     * @return float
     */
    private int interpol2Couleurs(float x, int c1, int c2) {
        int r1 = (int) red(c1);
        int r2 = (int) red(c2);
        int r3 = (int) interpol(x, r1, r2);

        int g1 = (int) green(c1);
        int g2 = (int) green(c2);
        int g3 = (int) interpol(x, g1, g2);

        int b1 = (int) blue(c1);
        int b2 = (int) blue(c2);
        int b3 = (int) interpol(x, b1, b2);

        return color(r3, g3, b3);
    }

    //--------------------------------------------
    /**ROLE : Interpolation de 4 couleurs
     *
     * @param x  float : Variable entre 0 et 1, sert à fluidifier l'interpolation.
     * @param c1 float : Couleur "c1" à inteporler pour chaque valeurs rgb.
     * @param c2 float : Couleur "c2" à inteporler pour chaque valeurs rgb.
     * @param c3 float : Couleur "c3" à inteporler pour chaque valeurs rgb.
     * @param c4 float : Couleur "c4" à inteporler pour chaque valeurs rgb.
     *
     * Le résultat de "c1" et "c2" interpolé sera interpolé avec le résultat de "c3" et "c4".
     *
     * @return float
     */
    private int interpol4Couleurs(float x, int c1, int c2, int c3, int c4) {
        int result1, result2, resultFinal;

        result1 = interpol2Couleurs(x, c1, c2);
        result2 = interpol2Couleurs(x, c3, c4);

        resultFinal = interpol2Couleurs(x, result1, result2);
        return resultFinal;
    }


    //**************************************** APPARENCE ********************************************
    /**ROLE : Calcul les coordeonne de l'etoile à ne pas de passer pour la particule.
     *
     * @param centre : Centre de référence, correspond au centre de l'étoile.
     * @param rayon : Correspond au rayon limite de chaque particule.
     * @param angle : Angle de polarité.
     * @return PVector
     */
    private PVector pol2Cart( PVector centre, float rayon, float angle ) {
        return new PVector ( centre.x + rayon*cos(angle), centre.y +rayon *sin(angle));
    }

    //-------------------------------------------------
    /** ROLE : Creation du centre de la particule */
    private void createCentre(){
        float angle      = random(0, 2 * PI);
        this.rayonLimite = random(-this.rayonLimite, this.rayonLimite);
        this.centrePart  = pol2Cart(this.centreEtoile, this.rayonLimite, angle);
    }

    //-------------------------------------------------
    /** ROLE : Dessin de la particule */
    public void drawPart(){
        //Dessin
        noStroke();
        float x = (float) ((this.dureeVie*0.005) / 100); //Pour fluidifier l'interpolation
        fill(this.interpol4Couleurs(x, c1,c2,c3,c4), this.alpha);
        circle(this.centrePart.x, this.centrePart.y, this.rayonPart);
    }


    //************************************** VIE PARTICULE ******************************************
    /** ROLE : Fait vivre les particules, additionne leur position avec la vélocité. */
    public void updatePart(){
            this.centrePart.add(this.velocite);
            this.dureeVie = millis() - this.naissance;
            this.alpha -= 0.01;
    }

    //-------------------------------------------------
    /** ROLE : Calcul la distance entre une particule et le centre de l'étoile. */
    private float distancePartToCentre(){
        //Ecart entre agent et centre de l'étoile.
        float ecart = sqrt(( ( centrePart.x - centreEtoile.x ) * ( centrePart.x - centreEtoile.x ) ) +
                                ( centrePart.y - centreEtoile.y ) * ( centrePart.y - centreEtoile.y ) ) ;
        return ecart;
    }

    //-------------------------------------------------
    /** ROLE : Verifie si la distance est supérieur au rayon de l'etoile ou sa vie dépasse 5 secondes.
     *
     * PRECONDITION : Limite et limiteTemps doit être initialisé.
     */
    public boolean verifLimite(float limite){
        return distancePartToCentre() > limite || this.dureeVie > limiteTemps;
    }


    //**************************************** DIMINUTION ********************************************
    /**ROLE : Diminue l'espace vitale des particules. */
    private void diminutionLimite(float coeff_a){
            this.rayonLimite -= coeff_a;
    }

    //-------------------------------------------------
    /** ROLE : Adapte la vélocité des particules à la diminution du rayon de l'étoile.
     * Permet de garder le mouvement sphérique pendant la diminution.
     * @param coeff
     */
    public void changementVelocite(float coeff) {
        float angle = PVector.angleBetween(this.centreEtoile, this.centrePart);
        int xadd, yadd;

        //Test la distance sur l'axe x entre le centre de l'etoile et le centre de "this" est inférieur à zero.
        //Si c'est le cas, la direction en x de "this" doit être négative.
        if (this.centreEtoile.x - this.centrePart.x <= 0) {
           xadd = -1;
        } else {
           xadd = 1;
        }
        //Idem pour y.
        if (this.centreEtoile.y - this.centrePart.y <= 0) {
           yadd = -1;
        } else {
            yadd = 1;
        }
        //Calcule la nouvelle vélocité pour la diminution du rayon.
        PVector dim = new PVector(coeff*xadd*sin(angle), coeff*yadd*sin(angle));
        this.centrePart.add(dim) ;
        this.diminutionLimite(coeff);
    }

}//FIN DE CLASSE
