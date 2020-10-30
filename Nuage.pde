import processing.core.PVector;
import java.util.ArrayList;

public class Nuage {


    private ArrayList listeElementsNuage;  //Liste des éléments du nuage.
    private int nbElementNuage; //Nombre d'élément dans le nuage.
    private ElementNuage elementNuageZero;  //Element zero.

    private  int iterateurFin; //Itérateur de fin des éléments utilisés.
    private int iterateurDebut; //Itérateur de début des éléments utilisés.

    private ArrayList particuleZero; //Liste des éléments zero.

    private int alpha; //Alpha des éléménents.

    //Constructeur
    public Nuage (int nbParticuleNuage) {

        this.listeElementsNuage = new ArrayList();
        this.nbElementNuage = nbParticuleNuage;

        //génération de la ParticuleNuage zero.
        this.elementNuageZero = new ElementNuage(width / 2.f, height / 2.f);
        this.listeElementsNuage.add(this.elementNuageZero);

        this.iterateurDebut = 0;
        this.iterateurFin = 0;

        this.particuleZero = new ArrayList();

        this.alpha = 0;
    }

    //************************************************** CREATION *************************************************
    /** ROLE : création des nouvelles particules entre itérateurDebut et itérateurFin.
     * PRECONDITION : Nombre de particules doit être > 150.
     */
    public void creationParticule() {
        if (this.nbElementNuage > 150) {
            for (int i = iterateurDebut; i <= iterateurFin; ++i) {
                ElementNuage p = (ElementNuage) this.listeElementsNuage.get(i);
                if (p.isfinAcceleration()) { //si l'acceleration est terminé.
                    if (p.isElementZero()) { //si la ParticuleNuage, génère pleins de nouvelles ParticuleNuage.
                        for (int j = 0; j < this.nbElementNuage; ++j) {
                            this.listeElementsNuage.add(p.nouvPoint());
                        }
                    }else { //sinon génère qu'un seul point.
                        this.listeElementsNuage.add(p.nouvPoint());
                    }
                    if (!p.isElementZero() && random(1) < 0.01) { //de temps en temps génère un nouveau point.
                        this.listeElementsNuage.add(p.nouvPoint());
                    }
                }
            }
            this.iterateurDebut = this.iterateurFin + 1;
            this.iterateurFin = this.listeElementsNuage.size();
        }
        this.nbElementNuage--;
    }

    //************************************************** VIE *************************************************
    /** ROLE : update des particules, renvois "True" quand toutes les particules ont bougé.
     * @return boolean : "true" quand toutes les particules ont fini de bouger.
     */
    public boolean updateParticules() {
        boolean finis = false;
        this.etoileNeutron(); //etoile à neutron central.

        for(int i = 0; i < this.listeElementsNuage.size(); ++i) { //Pour tout  les éléments de nuage.
            ElementNuage p = (ElementNuage) this.listeElementsNuage.get(i);
            p.update();
            p.drawElement();
            finis = p.isfinAcceleration(); //Tant que toutes les particules n'ont pas fini de bouger, finis = false.
        }
        return finis; //"false" quand toutes les particules n'ont pas bougé. "true" quand elles ont toutes bougés.
    }

    //-------------------------------------------------
    /** ROLE : condition d'arrêt de la classe nuage.
     *
     * @return boolean : "true" si le compteur d'éléments descend en dessous de 150.
     */
    public boolean conditionArret() {
        return this.nbElementNuage <= 150;
    }


    //******************************************* ETOILE A NEUTRONS ****************************************************
    /** ROLE : étoile à neutron au centre du nuage. */
    private void etoileNeutron() {
        if (this.alpha <= 255) { //Test si l'alpha n'est pas au maximum.
            this.alpha++;
        }
        PVector centreEtoile = new PVector(width / 2.f, height / 2.f); //L'étoile est rencentré.
        float angle = random(0,2) * PI; //Choix d'un angle de direction.

        PVector mouvement = new PVector(cos(angle)*2, sin(angle*2)); //Mouvement de deplacement.

        fill(216,191,216, this.alpha);
        circle(centreEtoile.x, centreEtoile.y, 20);

        centreEtoile.add(mouvement); //Bouge l'etoile, créer un effet de sursaut.

        circle(centreEtoile.x, centreEtoile.y, 20);
    }

} //FIN DE CLASSE
