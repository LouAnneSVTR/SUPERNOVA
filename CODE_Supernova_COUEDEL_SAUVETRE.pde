import processing.core.PApplet;
import processing.core.PImage;
import processing.sound.*;

    // >>>>>>>>>>>>>>>>> VARIABLES GLOBALES >>>>>>>>>>>>>>>>>
    Menu menu;
    boolean lancementSupernova, lancementInformation, lancementRetour, lancementRetourMenu, lancementSuivant, lancementPrecedent, finProgramme;
    PImage[] tabSupernova; //GIF Supernova.
    SoundFile musique;


    //**********************************************************************************************
    public void setup() {
        //Initialisation de processing
        //size(1200,700);
        fullScreen();

        //GIF DEBUT
        tabSupernova = new PImage[14];
        tabSupernova[0]  = loadImage("frame_00_delay-0.35s.gif");
        tabSupernova[1]  = loadImage("frame_01_delay-0.35s.gif");
        tabSupernova[2]  = loadImage("frame_02_delay-0.35s.gif");
        tabSupernova[3]  = loadImage("frame_03_delay-0.35s.gif");
        tabSupernova[4]  = loadImage("frame_04_delay-0.35s.gif");
        tabSupernova[5]  = loadImage("frame_05_delay-0.35s.gif");
        tabSupernova[6]  = loadImage("frame_06_delay-0.35s.gif");
        tabSupernova[7]  = loadImage("frame_07_delay-0.35s.gif");
        tabSupernova[8]  = loadImage("frame_08_delay-0.35s.gif");
        tabSupernova[9]  = loadImage("frame_09_delay-0.35s.gif");
        tabSupernova[10] = loadImage("frame_10_delay-0.35s.gif");
        tabSupernova[11] = loadImage("frame_11_delay-0.35s.gif");
        tabSupernova[12] = loadImage("frame_12_delay-0.35s.gif");
        tabSupernova[13] = loadImage("frame_13_delay-0.6s.gif");
        //GIF FIN

        menu = new Menu();

        //Booleen menu.
        lancementSupernova = false;
        lancementInformation = false;
        lancementRetour = false;
        lancementRetourMenu = false;
        lancementSuivant = false;
        lancementPrecedent = false;
        finProgramme = false;
        
        musique = new SoundFile(this, "hans-zimmer-stay-interstellar-main-theme.wav");
        //musique.initSound();
        musique.loop();
    }

    //**********************************************************************************************
    public void draw() {

        //Frame initial du programme. Permet de garder tous le long même après dessin du giff avec frameRate(4);
       frameRate(60);

        if (lancementSupernova) { //Démarrage de la supernova.
            menu.drawMenuPrincipal();
            menu.lancementBoutonSuperNova();

            if (menu.finProgramme()) { //Fin de la supernova.
                menu.drawBoutonFin();
                finProgramme = true;
            }

        } else if (lancementInformation && !lancementPrecedent && !lancementSuivant) { //Ouverture de l'informations.
            menu.drawMenuPrincipal();
            if (menu.lancementBoutonInformation() && menu.getNumeroPageInformation() == 2) {
                
                //Dessin du GIF de la Supernova.
                frameRate(3);
                image( this.tabSupernova[frameCount%14], width*74/100,height*39/100,height*30/100,height*20/100);
            }
            
        } else if (lancementPrecedent) { //Lancemeny de la page 1, la précédente.
            menu.drawInformation();
            lancementPrecedent = !menu.lancementBoutonPrecedent();

        } else if (lancementSuivant) { //Page suivante ( page 2 ).
            menu.drawInformation();
            lancementSuivant = !menu.lancementBoutonSuivant();

        } else if (lancementRetour) { //Retour dans le menu principal depuis les pages 1 et 2 d'Information.
            menu.drawInformation();
            lancementRetour = !menu.lancementBoutonRetourInformation();

        } else if (lancementRetourMenu) { //Retour vers le menu principal depuis la fin de la supernova.
            menu.drawBoutonFin();
            lancementRetourMenu =  !menu.lancementRetourSupernova();

        } else { //Menu principal, si il n'y aucun lancement.
            menu.drawMenuPrincipal();
        }
    }


    //******************************************** ACTION BOUTON ************************************************
    /** ROLE :  Dès qu'une action sur un bouton est effectué, la fonction lance les opérations correspondantes. */
    public void mouseClicked () {

        //Activation de la Supernova.
        if (menu.verificationBoutonSuperNova() && !lancementInformation && !lancementSupernova && !lancementRetourMenu && !lancementPrecedent && !lancementSuivant) {
            lancementSupernova = true;
            menu.tempsLancementSupernova();
            
        //Activation des pages information.
        } else if (menu.verificationBoutonInformation() && !lancementInformation && !lancementSupernova && !lancementRetourMenu && !lancementPrecedent && !lancementSuivant) {
            lancementInformation = true;

        //Retour vers l'écran principal depuis information.
        } else if (menu.verificationBoutonRetourInformation() && lancementInformation && !lancementSupernova && !lancementRetourMenu) {
            lancementInformation = false;
            lancementRetour = true;
            menu.reinitialisationBoutonInformation();

        //Depuis Information page 2, permet de retourner à la page 1.
        } else if (menu.verificationBoutonPrecedent() && lancementInformation && !lancementSupernova && !lancementRetourMenu) {
            lancementPrecedent = true;
            lancementSuivant = false;

        //Depuis Information page 1, permet d'acceder à la page 2.
        } else if (menu.verificationBoutonSuivant() && lancementInformation && !lancementSupernova && !lancementRetourMenu) {
            lancementPrecedent = false;
            lancementSuivant = true;

        //Permet de retourner au menu a la fin de la Supernova.
        } else if (menu.verificationBoutonRetourSupernova() && finProgramme && lancementSupernova && !lancementInformation) {
            lancementSupernova = false;
            finProgramme = false;
            lancementRetourMenu = true;
        }
    }
