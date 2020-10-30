 public interface Boutons {
    //-------------------------------------------
    /** ROLE : Dessine le rectangle qui compose le bouton ainsi que les trapèzes aux coordonnées correspondantes.
     * Ce sont ces 4 trapèzes qui donnent un effet de "relief". */
    public abstract void drawBouton();

    //-------------------------------------------
    /** ROLE : Effet du bouton lorsque la souris passe dessus.
     * Affiche les éléments décrit dans les sous-classe.  */
    public abstract void effetSouri();

    //-------------------------------------------
    /** ROLE : Dessine les effets de la souris quand on clique dessus.
     *
     *  @return boolean : "true" si l'affichage de l'effet est terminé.
     */
    public abstract boolean effetClicSouri();

    //-------------------------------------------
    /** ROLE : Lance le programme du bouton.
     *
     *  @return boolean : "true" si "effetClicSouri()" est terminé.
     */
    public abstract boolean lancementBouton();

    //-------------------------------------------
    /** ROLE : Vérifie si le curseur est bien sur le bouton.
     *
     *  @return boolean : Renvois "true" si oui.
     */
    public abstract boolean verificationBouton();


}
