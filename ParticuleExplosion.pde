import processing.core.PVector;

import java.util.Objects;

public class ParticuleExplosion {
    private PVector position;
    private PVector velocite;
    private float decelerationPart;
    private float angle;
    private float X, Y;
    private float taille, tailleMax, airDepart;
    private float pos_Depart_X, pos_Depart_Y;

    private int c1, c2, c3, c4;
    private float alpha;


    //Constructeur
    ParticuleExplosion(){
        this.taille    = random(5,20);

        //Création de la position de depart
        this.X         = width/2;
        this.Y         = height/2;

        this.airDepart = 5; //Reduit la zone de depart a 5 pixels
        pos_Depart_X   = X + random(-airDepart,airDepart);
        pos_Depart_Y   = Y + random(-airDepart,airDepart);

        this.position  = new PVector(pos_Depart_X, pos_Depart_Y) ;

        this.decelerationPart = 2;
        float mult     = random((float) 0.03,6);
        this.angle     = random(0,2)*PI;
        this.velocite  = new PVector(cos(this.angle)*mult* this.decelerationPart,sin(this.angle)*mult* this.decelerationPart);

        //Couleur des particules
        this.c1        = color(240, 200, 100); // ambre clair
        this.c2        = color(255, 150, 0); // tangerine clair
        this.c3        = color(187, 11, 11); // cerise
        this.c4        = color(135, 40, 50); //Passe velours

        this.alpha     = 100;

    }

    //Accesseur
    public float getAlpha() {
        return this.alpha;
    }


    //************************************** DESSIN DES PARICULES *******************************************
    /** ROLE : Dessine les particules et interpole les couleurs. */
    public void drawParticule() {

        noStroke();
        float x = (float) ((this.calcDistance()*0.25) / 100); //Pour fluidifier l'interpolation.
        fill(this.interpol4Couleurs(x, c1,c2,c3,c4), this.alpha);
        this.alpha -= 0.3;
        circle(position.x, position.y, this.taille);

    }


    //************************************ DEPLACEMENT DES PARICULES *****************************************
    /** ROLE : Fait avancer les particules */
    public void update(){
        position.add(velocite);
        this.decelerationPart-=0.05; //Ralentit l'explosion.
    }

    //--------------------------------------------
    /** ROLE : Renvoie "true" ou "false" si les particules sont sortit de leur limite de l'écran ou non.
     *
     * @return boolean
     */
    public boolean verificationLimite() {
        return this.position.x < 0 || this.position.x > width || this.position.y < 0 || this.position.y > height;
    }

    //--------------------------------------------
    /**ROLE : Calcul la distance entre la positions des départs des particules et leur position actuelles.
     *
     * @return float
     */
    private float calcDistance() {
        return sqrt((pos_Depart_X - position.x) * (pos_Depart_X - position.x) + (pos_Depart_Y - position.y) * (pos_Depart_Y - position.y));
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

    //************************************** EQUALS & HASH CODE *******************************************
    /** ROLE : Compare tous les attributs de "this" et o.
     * PRECONDITION : Objetct o doit être initialiser.
     *
     *  @param o : Objet comparé avec le "this".
     *  @return boolean
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true; //Test si "this" hérite de Object.

        if (!(o instanceof ParticuleExplosion)) return false;  //Test si o est un onbjet de type ParticuleExplosion.

        ParticuleExplosion that = (ParticuleExplosion) o; //Cast o en ParticuleExplosion.

        //Retourne "true" si les attributs de o et "this" sont les mêmes.
        return Float.compare(that.decelerationPart, decelerationPart) == 0 &&
                Float.compare(that.angle, angle) == 0 &&
                Float.compare(that.X, X) == 0 &&
                Float.compare(that.Y, Y) == 0 &&
                Float.compare(that.taille, taille) == 0 &&
                Float.compare(that.tailleMax, tailleMax) == 0 &&
                Float.compare(that.airDepart, airDepart) == 0 &&
                Float.compare(that.pos_Depart_X, pos_Depart_X) == 0 &&
                Float.compare(that.pos_Depart_Y, pos_Depart_Y) == 0 &&
                c1 == that.c1 &&
                c2 == that.c2 &&
                c3 == that.c3 &&
                c4 == that.c4 &&
                Float.compare(that.getAlpha(), getAlpha()) == 0 &&
                position.equals(that.position) &&
                velocite.equals(that.velocite);
    }

    //--------------------------------------------
    /** ROLE : Hash l'objet "this"
     *  Fonctionne en duo avec le méthode equals.
     *
     * @return int ( rerprésentant le code hash )
     */
    @Override
    public int hashCode() {
        return Objects.hash(position, velocite, decelerationPart, angle, X, Y, taille, tailleMax, airDepart, pos_Depart_X, pos_Depart_Y, c1, c2, c3, c4, getAlpha());
    }


}//FIN DE CLASSE
