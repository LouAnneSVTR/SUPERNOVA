import processing.core.PVector;
import java.util.ArrayList;

public class ArrierePlan {

    private ArrayList<EtoileArrierePlan> listeEtoiles;
    private int nbEtoile;
    private float alpha;

    //Constructeur
    public ArrierePlan(int nbEtoile) {

        //Initialisation de la liste d'étoile en fond.
        this.listeEtoiles = new ArrayList<EtoileArrierePlan>();

        //Nombre d'étoile utilié.
        this.nbEtoile = nbEtoile;

        //Alpha du flash.
        alpha = 255;
    }

    //******************************* INITIALISATION ET DRAW *************************************
    /** ROLE : Initialise les étoiles de l'arriere plan. */
    public void initEtoiles() {
        for (int i = 0 ; i < nbEtoile ; ++i) {
            listeEtoiles.add(new EtoileArrierePlan());
        }
    }

    //----------------------------------------------
    /** ROLE : Dessine les étoiles de l'arriere plan.
     * PRECONDITION : Les étoiles doivent avoir étét initialisée auparavant.*/
    public void drawEtoiles() {
        background(0, 0, 15);

        for (int i = 0 ; i < nbEtoile ; ++i) {
            EtoileArrierePlan e = this.listeEtoiles.get(i);
            if (random(1) < 0.005) { //Permet de faire scintiller 0.5% des étoiles.
                e.sintillement();
            }
            e.drawEtoile();
        }
    }

    //******************************************* FLASH *******************************************
    /**ROLE : Rends pendant un temps donnée un arrier plan blanc pour donner un effet de flash.
     *
     * @param temps int : temps actuel.
     */
    public void flash(int temps) {
        if (alpha >=0) {
            fill(255, alpha);
            rect(0,0, width * 2, height * 2);
            this.alpha = this.alpha - temps; // Donne la durée du flash.
        }
    }
}
