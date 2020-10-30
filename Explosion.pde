import processing.core.PVector;
import java.util.ArrayList;

public class Explosion {
    private ArrayList  ListePart;
    private int nbPart;

    //----------------------------------------------
    //Constructeur
    public Explosion(int nb){
        this.nbPart = nb;
        this.ListePart = new ArrayList();
    }

    //************************************* INITIALISATION EXPLOSION ***************************************
    /** ROLE : Pre-traitement des particules, création des listes d'Amas de nbElem particules. */
    public void initialisationExplosion() {
        for (int i = 0; i < this.nbPart; i++) {
            this.ListePart.add(new  ParticuleExplosion()); //Ajoute les particules à la liste de l'explosion.
        }
    }

    //**************************************** DESSIN EXPLOSION ****************************************
    /** ROLE : Dessine les particules de l'explosion.
     *  Test si la particule est toujours dans le cadre ou non.
     *
     *  PRECONDITION : Liste doit être initialisé.
     */
    public void drawExplosion(){

        noStroke();
        fill(176,224,230, 50);

        for (int i = 0 ; i <  this.ListePart.size() ; i++){
            ParticuleExplosion p = ( ParticuleExplosion) this.ListePart.get(i);
            if (p.verificationLimite()) { //Test si la particule à dépassé le cadre.
                this.ListePart.remove(p); //Supprime les particules.
            } else {
                p.drawParticule(); //Dessine.
                p.update(); //Faut avancer les éléments.
            }
        }
    }

    //*************************************** CONDITIONS EXPLOSION ****************************************
    /** ROLE : Test si l'alpha des éléments de l'explosion est < à 50.
     * Représente la condition de lancement du nuage de gaz.
     * PRECONDITION : Alpha initalisé.
     *
     * @return boolean
     */
    public boolean conditionLancement() {
        ParticuleExplosion p = (ParticuleExplosion) this.ListePart.get(0);
        return p.getAlpha() < 50;
    }

    //----------------------------------------------
    /** ROLE : Test si les particules sont transparantes.
     * Sert de condition de fin de vie aux particules.
     * PRECONDITION : Alpha initalisé.
     *
     * @return boolean
     */
    public boolean conditionArret() {
        ParticuleExplosion p = (ParticuleExplosion) this.ListePart.get(0);
        return p.getAlpha() <= 0;
    }

}//FIN DE CLASSE
