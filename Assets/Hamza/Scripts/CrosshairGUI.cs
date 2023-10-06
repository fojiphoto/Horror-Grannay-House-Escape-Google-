using UnityEngine;
using System.Collections;
using UnityStandardAssets.Characters.FirstPerson;

public class CrosshairGUI : MonoBehaviour
{
	[Header("Crosshair Setting")]

	[Space]

	public Texture2D m_crosshairTexture;
	public Texture2D m_useTexture;
	public float RayLength = 3f;

	public bool m_DefaultReticle;
	public bool m_UseReticle;
	public bool m_ShowCursor = false;

	private bool m_bIsCrosshairVisible = true;
	private Rect m_crosshairRect;
	private Ray playerAim;
	private Camera playerCam;
    public GameObject standpos, sitpos, sitbtn, standbtn,letter, hidebtn, currenthideobj, houselight, fuseshock, libraryfire, tablefire, saveduncle, savedmom,gamepannel,mission;
    public bool hidden, mapchk, Fusechk;
	[Space]
	[Space]

	[Header("Sounds")]

	[Space]


	public AudioSource AS;

    public AudioClip DoorSFX;
	public AudioClip PopUpSFX;
	public AudioClip PickupSFX;
	public AudioClip SmashLaptopSFX;
	public AudioClip CryTeacherSFX;
    public AudioClip levelincrement;
	


	[Space]
	[Space]

	[Header("Player")]

	[Space]

	public GameObject Player;
	public GameObject PlayerControls;

	[Space]
	[Space]

	[Header("Level 1  Find Key")]

	[Space]

	public bool PickKey;
	public bool PlayerKey, Playerfusebool;
	public bool MainDoorAnim;
	public bool OnlyMainDoor;

	public static bool MainDoorText = true;

	public GameObject UnlockMainDoorTextBox;

	public GameObject KeyToFind;
	public GameObject PlayerHandKey, PlayerFuse;
    public GameObject dummylock;

	[Space]
	[Space]


	[Header("Level 2  Smash Laptop")]

	[Space]

	public bool HammerDraw;
	public bool Hammer;
	public bool SmashHammer;

	public GameObject LaptopCrashTextBox;
	public GameObject TeacherCryLawn;
	public GameObject DrawHammer;
	public GameObject PlayerHammer;
	public GameObject TeacherWalkingInLawn;
	public GameObject LaptopShock;

    [Space]
    [Space]

    [Header("Level 3  Ruin Dress")]

    [Space]

    public bool isTableMarker;
    public bool isPhotoMarker;

    public GameObject TableMarker;
    public GameObject PlayerMarker;
    public GameObject PhotoMarker;
    public GameObject RuinedPhoto;

    public GameObject Level3TeacherWalking;
    public GameObject TeacherCryingLevel3;

    [Space]
    [Space]

    [Header("Level 4  Cut Dress")]

    [Space]

    public bool Scissor;
    public bool CupboardDoor;
    public bool Dress;

    public GameObject ShelveScissor;
    public GameObject PlayerScissor;

    public GameObject RoomCupboards;

    public GameObject CutDressTextBox;
    public GameObject RealDress;
    public GameObject CutDress;

    public GameObject Level7Scene;
    public GameObject TeacherWalkingCoridorLevel7;


    [Space]
    [Space]


   


	[Header("Level   Hide Mobile")]

	[Space]

	public bool Drawer;
	public bool Mobile;

	public GameObject MobileDrawer;
	public GameObject MobilePlayer;

	public GameObject ThrowPointTextBox;
	public GameObject ThrowPoint;

	public GameObject teacherWalkingInCoridor;
	public GameObject SceneLevel5, SceneLevel6;


	[Space]
	[Space]


    [Header("Level 6  Book")]

    [Space]


    public bool Book;

    public GameObject BookTextBox;

    public GameObject ShelveBook;
    public GameObject PlayerBook;
    public GameObject HomeOutPoint;


    [Space]
    [Space]

    [Header("Level 5 Bathroom Fire")]

    [Space]
    public bool TercDoorAnim;
    public bool ScrewDriver;
    public bool BathroomDoorAnim;
    public bool Lighter;
    public bool ThrowLighter;

    public GameObject ScrewDriverTextBox;
    public GameObject FindLighterTextBox;

    public GameObject ScrewDriverTable;
    public GameObject ScrewDriverPlayer;
    public GameObject LighterKitchen;
    public GameObject LighterPlayer;
    public GameObject Fire;
    public GameObject TeacherCry;

    [Space]
    [Space]

    [Header("Level 10  Break TV")]

    [Space]

    public bool Stick;
    public bool BreakTV;

    public GameObject LawnStick;
    public GameObject PlayerStick;
    public GameObject Broken;


    [Space]
    [Space]

    [Header("Level 9  Ruin Pizza")]

    [Space]

    public bool Pizza;

    public GameObject TeacherWalkingLevel9;
    public GameObject SceneLevel9;


    [Space]
    [Space]

    [Header("Level 10  bomb")]
    [Space]

    public bool bomb;
    public GameObject bombthrowpoint, playerbomb, bombtextbox, story, bombmain;

    [Space]
    [Space]



    public bool Door,dd;

    public GameObject detecteddoor, detecteddrawer, detectedbathdoor, detectedobj;

    public GameObject openbtn, pickbtn;


    public GameObject CompleteTaskPanel;
    public GameObject NextButton;



    public bool Ads;
    public GameObject locked;

    private void Start()
	{
		AS = GetComponent<AudioSource>();

        Ads = true;

        if (PlayerPrefs.GetInt("light") == 1)
        {
            houselight.GetComponent<Light>().intensity = 0.8f;
        }
        else {

            houselight.GetComponent<Light>().intensity = 0.2f;
        }

        if (PlayerPrefs.GetInt("Level") <= 1)
        {
            PlayerPrefs.SetInt("maindoorunlock", 0);
        }
        else
        {
            PlayerPrefs.SetInt("maindoorunlock",2);
        }

        if (PlayerPrefs.GetInt("Level") == 0)
        {
            PlayerPrefs.SetInt("Hammer", 0);
        }
        if (PlayerPrefs.GetInt("Level") == 6)
        {
            PlayerPrefs.SetInt("bathroomdoorunlock", 0);
            PlayerPrefs.SetInt("lighter", 0);
        }

        if (PlayerPrefs.GetInt("map") == 1)
        {
           // Mapbtn.SetActive(true);
        }
    }

    void Update()

    {
        playerCam = Camera.main;
        Ray playerAim = playerCam.GetComponent<Camera>().ViewportPointToRay(new Vector3(0.5f, 0.5f, 0));
        RaycastHit hit;


        if (Physics.Raycast(playerAim, out hit, RayLength))

        {
            //Debug.Log(hit.collider.gameObject);

            if (hit.collider.gameObject.tag == "Untagged" || hit.collider.gameObject == null)
            {
                pickbtn.SetActive(false);
                openbtn.SetActive(false);
                
            }
            ////// Level 1 Start ............................................

            if (hit.collider.gameObject.tag == "books" && Lighter == true) {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                openbtn.SetActive(true);
                
            }
            if (hit.collider.gameObject.tag == "burnarea" && Lighter == true)
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                openbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "uncle")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                openbtn.SetActive(true);
            }
            if (hit.collider.gameObject.tag == "mom")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                openbtn.SetActive(true);
            }

            if (hit.collider.gameObject.tag == "keytwo")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                pickbtn.SetActive(true);
            }


            if (hit.collider.gameObject.tag == "keythree")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                pickbtn.SetActive(true);
            }

            if (hit.collider.gameObject.tag == "map")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                mapchk = true;
                detectedobj = hit.collider.gameObject;
                pickbtn.SetActive(true);
            }

            if (hit.collider.gameObject.tag == "Fuse")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Fusechk = true;
                detectedobj = hit.collider.gameObject;
                pickbtn.SetActive(true);
            }
            if (hit.collider.gameObject.tag == "radio")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                detectedobj = hit.collider.gameObject;
                pickbtn.SetActive(true);
            }


            if (hit.collider.gameObject.tag == "key")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                PickKey = true;
                pickbtn.SetActive(true);
            }

            if (hit.collider.gameObject.tag == "firstdoor" && PlayerKey == true)
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                UnlockMainDoorTextBox.SetActive(false);
                MainDoorAnim = true;
                openbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "firstdoor" && PlayerKey == true)
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                UnlockMainDoorTextBox.SetActive(false);
                MainDoorAnim = true;
                openbtn.SetActive(true);
            }


            if (hit.collider.gameObject.tag == "firstdoor")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
				if (PlayerPrefs.GetInt("maindoorunlock") == 1)
				{
					MainDoorAnim = true;
                    openbtn.SetActive(true);
                }
				else if (MainDoorText == true && !(PlayerPrefs.GetInt("maindoorunlock") == 2))
				{
					UnlockMainDoorTextBox.SetActive(true);
					AS.PlayOneShot(PopUpSFX);
				}
			}

			if (hit.collider.gameObject.tag == "firstdoor")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
				OnlyMainDoor = true;
				if (PlayerPrefs.GetInt("maindoorunlock") == 2)
				{
					MainDoorAnim = true;
                    openbtn.SetActive(true);
                }

			}



   
            if (hit.collider.gameObject.tag == "tercdoor")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                TercDoorAnim = true;

            }
            if (hit.collider.gameObject.tag == "bathroomdoor")
            {
                detectedbathdoor = hit.collider.gameObject;
                m_DefaultReticle = false;
                m_UseReticle = true;
                openbtn.SetActive(true);
                if (PlayerPrefs.GetInt("bathroomdoorunlock") == 1)
                {
                    BathroomDoorAnim = true;
                }
                else
                {
                    ScrewDriverTextBox.SetActive(true);
                    AS.PlayOneShot(PopUpSFX);
                }

            }
            if (hit.collider.gameObject.tag == "scredriver")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                pickbtn.SetActive(true);
                ScrewDriver = true;

            }
            if (hit.collider.gameObject.tag == "lighter")
            {
                detectedobj = hit.collider.gameObject;
                m_DefaultReticle = false;
                m_UseReticle = true;
                pickbtn.SetActive(true);
                Lighter = true;

            }
            if (hit.collider.gameObject.tag == "bathroomblind")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
               
                openbtn.SetActive(true);

                if (hit.collider.gameObject.tag == "bathroomblind" && PlayerPrefs.GetInt("lighter") == 1)
                {
                    ThrowLighter = true;
                }
                else
                {
                    FindLighterTextBox.SetActive(true);
                    AS.PlayOneShot(PopUpSFX);
                }
            }

            if (hit.collider.gameObject.tag == "hammerdraw")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
               
                openbtn.SetActive(true);
                HammerDraw = true;

			}

			if (hit.collider.gameObject.tag == "hammer")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
                pickbtn.SetActive(true);
                
                Hammer = true;

			}

			if (hit.collider.gameObject.tag == "laptop")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
               
                openbtn.SetActive(true);

                if (hit.collider.gameObject.tag == "laptop" && PlayerPrefs.GetInt("Hammer") == 1)
				{
					SmashHammer = true;
				}
				else
				{
					LaptopCrashTextBox.SetActive(true);
					AS.PlayOneShot(PopUpSFX);
				}
			}


            //////////////////////////////////////////////////////////////////////Ruin Dress//////////////////////////////////////////////////////////////////

            if (hit.collider.gameObject.tag == "tablemarker")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                pickbtn.SetActive(true);
                isTableMarker = true;

            }

            if (hit.collider.gameObject.tag == "photo")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                isPhotoMarker = true;
                openbtn.SetActive(true);

            }

            ////// Level 2 End ............................................


            if (hit.collider.gameObject.tag == "scissor")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Scissor = true;
                pickbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "cupboarddoor")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                CupboardDoor = true;
                openbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "dress")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                openbtn.SetActive(true);
                Dress = true;

            }

            if (hit.collider.gameObject.tag == "drawer")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Drawer = true;
                openbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "mobile")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Mobile = true;
                pickbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "bomb")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                bomb = true;
                pickbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "book")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Book = true;
                pickbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "stick")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Stick = true;
                pickbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "breaktv")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                BreakTV = true;
                openbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "pizza")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                Pizza = true;
                openbtn.SetActive(true);

            }

            if (hit.collider.gameObject.tag == "FuseBox" && Playerfusebool == true)
            {
                detectedobj = hit.collider.gameObject;
                m_DefaultReticle = false;
                m_UseReticle = true;
                openbtn.SetActive(true);

            }
            ///////// Doors


            if (hit.collider.gameObject.tag == "door")
			{

				m_DefaultReticle = false;
				m_UseReticle = true;
				Door = true;
                detecteddoor = hit.collider.gameObject;
               
                openbtn.SetActive(true);

            }
            if (hit.collider.gameObject.tag == "dd")
            {

                m_DefaultReticle = false;
                m_UseReticle = true;
                dd = true;
                detecteddrawer = hit.collider.gameObject;

                openbtn.SetActive(true);

            }

        }

		else

		{
			m_DefaultReticle = true;
			m_UseReticle = false;
            pickbtn.SetActive(false);
            openbtn.SetActive(false);

            //Level 1

            UnlockMainDoorTextBox.SetActive(false);
			PickKey = false;
			MainDoorAnim = false;
			OnlyMainDoor = false;

            //Level 2

            LaptopCrashTextBox.SetActive(false);
            HammerDraw = false;
            Hammer = false;


            //////////////////////////////////////// Ruin Photo ///////////////////////////////////////////////

            isTableMarker = false;
            isPhotoMarker = false;

            //////////////////////////////////////// Ruin Dress ///////////////////////////////////////////////

            Scissor = false;
            CupboardDoor = false;
            Dress = false;

            //////////////////////////////////////// Hide Mobile ///////////////////////////////////////////////

            Drawer = false;
            Mobile = false;


            bomb = false;
            //////////////////////////////////////// Steal Mobile ///////////////////////////////////////////////

            Book = false;

            //////////////////////////////////////// Shower ///////////////////////////////////////////////


            ScrewDriverTextBox.SetActive(false);
            FindLighterTextBox.SetActive(false);
            BathroomDoorAnim = false;
            TercDoorAnim = false;
            ScrewDriver = false;
           // Lighter = false;
            ThrowLighter = false;

           

            // Doors

            Door = false;
            dd = false;
        }

	}




	void Awake()
	{
		if (m_DefaultReticle)
		{
			m_crosshairRect = new Rect((Screen.width - m_crosshairTexture.width) / 2,
								  (Screen.height - m_crosshairTexture.height) / 2,
								  m_crosshairTexture.width,
								  m_crosshairTexture.height);
		}

		if (m_UseReticle)
		{
			m_crosshairRect = new Rect((Screen.width - m_useTexture.width) / 2,
								  (Screen.height - m_useTexture.height) / 2,
								  m_useTexture.width,
								  m_useTexture.height);
		}
	}

    public void sit() {

        sitbtn.SetActive(false);
        standbtn.SetActive(true);
        this.gameObject.GetComponent<CharacterController>().height = 4f;
        iTween_new.MoveTo(this.gameObject.GetComponent<ainew>().playercamera.gameObject, iTween_new.Hash("x", sitpos.transform.localPosition.x, "y", sitpos.transform.localPosition.y, "z", sitpos.transform.localPosition.z, "time", 0.5f, "islocal", true, "easetype", iTween_new.EaseType.linear));
        this.gameObject.GetComponent<FirstPersonController>().m_RunSpeed = 2f;


            }

    public void stand()
    {
        standbtn.SetActive(false);
        sitbtn.SetActive(true);
        this.gameObject.GetComponent<CharacterController>().height = 5.5f;
        iTween_new.MoveTo(this.gameObject.GetComponent<ainew>().playercamera.gameObject, iTween_new.Hash("x", standpos.transform.localPosition.x, "y", standpos.transform.localPosition.y, "z", standpos.transform.localPosition.z, "time", 0.5f, "islocal", true, "easetype", iTween_new.EaseType.linear));
        this.gameObject.GetComponent<FirstPersonController>().m_RunSpeed = 6f;
    }


    public void Mapopen() {

        PlayerControls.SetActive(false);
        GetComponent<CrosshairGUI>().enabled = false;
        //Map.SetActive(true);
        //Mappanel.SetActive(true);

    }

    public void Mapclose() {

        PlayerControls.SetActive(true);
        GetComponent<CrosshairGUI>().enabled = true;
        //Map.SetActive(false);
        //Mappanel.SetActive(false);

    }

    void OnGUI()
	{
		if (m_bIsCrosshairVisible)
			if (m_DefaultReticle)
			{
				GUI.DrawTexture(m_crosshairRect, m_crosshairTexture);
			}
		if (m_UseReticle)
		{
			GUI.DrawTexture(m_crosshairRect, m_useTexture);
		}
	}

    public void letteroff()
    {
        letter.SetActive(false);
        gamepannel.SetActive(true);
        mission.SetActive(true);
    }

    public void PickUp()
    {
        /// Level 1 Start
        ///
        if (!(detectedobj == null)) {

            if (detectedobj.tag == "radio")
            {
                AS.PlayOneShot(PickupSFX);
                detectedobj.SetActive(false);
                Invoke("OnComplete", 3f);
            }
            else if (detectedobj.tag == "keytwo") {

                AS.PlayOneShot(PickupSFX);
                detectedobj.SetActive(false);
                Invoke("OnComplete", 3f);
            }
            else if (detectedobj.tag == "keythree")
            {

                AS.PlayOneShot(PickupSFX);
                detectedobj.SetActive(false);
                Invoke("OnComplete", 3f);
            }

        }

		if (PickKey == true)
		{
			AS.PlayOneShot(PickupSFX);
			KeyToFind.SetActive(false);
			PlayerHandKey.SetActive(true);
			PlayerKey = true;
			MainDoorText = false;
			PlayerPrefs.SetInt("maindoorunlock", 1);

		}


        if (mapchk == true)
        {
            AS.PlayOneShot(PickupSFX);
            detectedobj.SetActive(false);
            PlayerPrefs.SetInt("map", 1);
            letter.SetActive(true);
            gamepannel.SetActive(false);
            mission.SetActive(false);
           // Mapbtn.SetActive(true);
            Invoke(nameof(letteroff), 9.5f);Invoke("OnComplete", 10f);
            mapchk = false;

        }
        if (Fusechk == true)
        {
            AS.PlayOneShot(PickupSFX);
            detectedobj.SetActive(false);
            PlayerFuse.SetActive(true);
            Playerfusebool = true;
            Fusechk = false;

        }


        //  Level 1 End       ..........................................................................

        //  Level 2 Start       ..........................................................................

        if (Hammer == true)

		{
			AS.PlayOneShot(PickupSFX);
			DrawHammer.SetActive(false);
			PlayerHammer.SetActive(true);
			PlayerPrefs.SetInt("Hammer", 1);
		}




        if(isTableMarker == true)
        {
            TableMarker.SetActive(false);
            PlayerMarker.SetActive(true);
            GameObject.FindGameObjectWithTag("photo").GetComponent<BoxCollider>().enabled = true;
        }



        //  Level 2 End       ..........................................................................


        if (Scissor == true)
        {
            AS.PlayOneShot(PickupSFX);
            ShelveScissor.SetActive(false);
            PlayerScissor.SetActive(true);
            RoomCupboards.SetActive(true);
            CutDressTextBox.SetActive(true);
            Invoke("CutDressTextBoxWait", 4.0f);
        }


        if (Mobile == true)
        {
            AS.PlayOneShot(PickupSFX);
            MobileDrawer.SetActive(false);
            MobilePlayer.SetActive(true);
            ThrowPointTextBox.SetActive(true);
            ThrowPoint.SetActive(true);
            Invoke("ThrowPointTextBoxwait", 4.0f);
        }

        if (bomb == true)
        {
            AS.PlayOneShot(PickupSFX);
            bombmain.SetActive(false);
            playerbomb.SetActive(true);
            bombtextbox.SetActive(true);
            bombthrowpoint.SetActive(true);
            Invoke("ThrowPointTextBoxwaitbomb", 4.0f);
        }

        if (Book == true)
        {
            AS.PlayOneShot(PickupSFX);
            ShelveBook.SetActive(false);
            PlayerBook.SetActive(true);
            HomeOutPoint.SetActive(true);
            BookTextBox.SetActive(true);
            Invoke("BookTextBoxWait", 3.0f);
        }


        if (ScrewDriver == true)
        {
            AS.PlayOneShot(PickupSFX);
            ScrewDriverTable.SetActive(false);
            ScrewDriverPlayer.SetActive(true);
            PlayerPrefs.SetInt("bathroomdoorunlock", 1);
        }
        if (Lighter == true && detectedobj.tag == "lighter")
        {
            AS.PlayOneShot(PickupSFX);
            //  LighterKitchen.SetActive(false);
            detectedobj.SetActive(false);
            LighterPlayer.SetActive(true);
            //PlayerPrefs.SetInt("lighter", 1);
        }

        if (Stick == true)
        {
            AS.PlayOneShot(PickupSFX);
            LawnStick.SetActive(false);
            PlayerStick.SetActive(true);
            GameObject.FindGameObjectWithTag("breaktv").GetComponent<BoxCollider>().enabled = true;
        }


   

    }



    public void PerformAction()
	{


		/// Level One Complete


		if (MainDoorAnim == true && PlayerPrefs.GetInt("maindoorunlock") ==1) 
		{
            locked.SetActive(false);
            dummylock.SetActive(true);
            dummylock.AddComponent<Rigidbody>();
            GameObject.FindGameObjectWithTag("firstdoor").GetComponent<dooropener>().openercloser();
            AS.PlayOneShot(DoorSFX);
			PlayerPrefs.SetInt("maindoorunlock", 2);
			PlayerHandKey.SetActive(false);
            Debug.Log("firstttttttttttt");
            
            Invoke("OnComplete", 3f);

		}


        if (PlayerPrefs.GetInt("maindoorunlock") == 2 && OnlyMainDoor == true)
        {
            Debug.Log("secondddddddddddddd");
            
            GameObject.FindGameObjectWithTag("firstdoor").GetComponent<dooropener>().openercloser();
            AS.PlayOneShot(DoorSFX);
        }

        //  Level One End       ..........................................................................


        /// Level 2 Start ..................................................................................

        if (HammerDraw == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("hammerdraw").GetComponent<Animator>().enabled = true;
        }

        if (Hammer == true)

        {
            AS.PlayOneShot(PickupSFX);
            DrawHammer.SetActive(false);
            PlayerHammer.SetActive(true);
            PlayerPrefs.SetInt("Hammer", 1);
        }

        if (SmashHammer == true)

        {
            AS.PlayOneShot(SmashLaptopSFX);
            GameObject.FindGameObjectWithTag("hammerplayer").GetComponent<Animator>().enabled = true;
            LaptopShock.SetActive(true);
            Invoke("CryTeacherLawn", 3.0f);
        }


        /////////////////////////////////////////////////// Ruin Photo ///////////////////////////////////////
        ///

        if(isPhotoMarker == true)
        {
            PlayerMarker.SetActive(false);
            PhotoMarker.SetActive(true);
            Invoke("PhotoMarkerOff", 3.0f);
            
        }

        /////////////////////////////////////////////////// Ruin Dress ///////////////////////////////////////

        if (CupboardDoor == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("cupboarddoor").GetComponent<Animator>().enabled = true;

        }
        if (Dress == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("scissorplayer").GetComponent<Animator>().enabled = true;
            RealDress.SetActive(false);
            CutDress.SetActive(true);
            Invoke("Level7Scenewait", 2.0f);
        }


        if (Drawer == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("drawer").GetComponent<Animator>().enabled = true;

        }



        if (ThrowLighter == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("throwlighter").GetComponent<Animator>().enabled = true;
            Fire.SetActive(true);

            PlayerControls.SetActive(false);
            Invoke("CryTeacherBathroom", 1.0f);
        }

        if (BathroomDoorAnim == true)
        {

            //GameObject.FindGameObjectWithTag("bathroomdoor").GetComponent<Animator>().Play("door");
            detectedbathdoor.GetComponent<Animator>().Play("door");
            AS.PlayOneShot(DoorSFX);
            ScrewDriverPlayer.SetActive(false);
            LighterKitchen.SetActive(true);

        }

        if (BreakTV == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("playerstick").GetComponent<Animator>().enabled = true;
            Broken.SetActive(true);
            Invoke("OnComplete", 2.5f);
        }

        if (Pizza == true)
        {
            AS.PlayOneShot(PickupSFX);
            GameObject.FindGameObjectWithTag("pizza").GetComponent<Animator>().enabled = true;

            Invoke("SceneLevel9wait", 2.5f);
        }
        if (!(detectedobj == null))
        {

            if (detectedobj.tag == "FuseBox" && Playerfusebool == true)
            {
                AS.PlayOneShot(SmashLaptopSFX);
                PlayerFuse.SetActive(false);
                fuseshock.SetActive(true);
                houselight.GetComponent<Light>().intensity = 0.8f;
                PlayerPrefs.SetInt("light", 1);
                Playerfusebool = false;
                detectedobj = null;
                Invoke("OnComplete", 3f);

            }
            else if (detectedobj.tag == "books" && Lighter == true) {

                AS.PlayOneShot(PickupSFX);
                LighterPlayer.SetActive(false);
                libraryfire.SetActive(true);
                Lighter = false;
                detectedobj = null;
                Invoke("OnComplete", 3f);
            }
            else if (detectedobj.tag == "uncle")
            {
                AS.PlayOneShot(PickupSFX);
                detectedobj.SetActive(false);
                saveduncle.SetActive(true);
                detectedobj = null;
                Invoke("OnComplete", 3f);
            }
            else if (detectedobj.tag == "mom")
            {
                AS.PlayOneShot(PickupSFX);
                detectedobj.SetActive(false);
                savedmom.SetActive(true);
                detectedobj = null;
                Invoke("OnComplete", 3f);
            }
            else if (detectedobj.tag == "burnarea" && Lighter == true)
            {

                AS.PlayOneShot(PickupSFX);
                LighterPlayer.SetActive(false);
                tablefire.SetActive(true);
                Lighter = false;
                detectedobj = null;
                Invoke("OnComplete", 3f);
            }

        }
            /// 
            ////// Doors
            ///
            if (Door == true)
        {
            //   detecteddoor.GetComponent<Animator>().enabled = true;
            //  detecteddoor.GetComponent<Animator>().Play("door");
          
            detecteddoor.GetComponent<dooropener>().openercloser();
           
            AS.PlayOneShot(DoorSFX);
		}

        else if (dd == true)
        {
            //   detecteddoor.GetComponent<Animator>().enabled = true;
            //  detecteddoor.GetComponent<Animator>().Play("door");

            detecteddrawer.GetComponent<draweropener>().drawer();

            AS.PlayOneShot(DoorSFX);
        }

    }


    
    /// Level 2 Start  ......................

    public void CryTeacherLawn()
    {
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        TeacherWalkingInLawn.SetActive(false);
        TeacherCryLawn.SetActive(true);
        AS.PlayOneShot(CryTeacherSFX);
        Invoke("OnComplete", 4.5f);
    }


    /// Level 2 End ....................
    ///

    public void PhotoMarkerOff()
    {
        PhotoMarker.SetActive(false);
        RuinedPhoto.SetActive(true);
        Invoke("Level3TeacherCrying", 3.0f);
    }
    public void Level3TeacherCrying()
    {
        Level3TeacherWalking.SetActive(false);
        Player.SetActive(false);
        TeacherCryingLevel3.SetActive(true);
        PlayerControls.SetActive(false);
        Invoke("OnComplete", 5.0f);
    }


    public void CutDressTextBoxWait()
    {
        CutDressTextBox.SetActive(false);
    }

    public void BookTextBoxWait()
    {
        BookTextBox.SetActive(false);
    }

    public void Level7Scenewait()
    {
        Level7Scene.SetActive(true);
        TeacherWalkingCoridorLevel7.SetActive(false);
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        Invoke("OnComplete", 13.0f);
    }


    public void ThrowPointTextBoxwait()
    {
        ThrowPointTextBox.SetActive(false);

    }
    public void ThrowPointTextBoxwaitbomb()
    {
        bombtextbox.SetActive(false);

    }
    public void PlayerMobilewait()
    {
        MobilePlayer.SetActive(false);
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        SceneLevel5.SetActive(true);
        teacherWalkingInCoridor.SetActive(false);
        Invoke("OnComplete", 13.0f);
    }


    public void OnTriggerEnter(Collider other)
    {
      

        if (other.tag == "throwmobile")
        {
            SceneLevel5.SetActive(true);
            ThrowPoint.SetActive(false);
            Player.SetActive(false);
            Invoke("OnComplete", 8.0f);

        }
        if (other.tag == "throwbomb")
        {
            story.SetActive(true);
            bombthrowpoint.SetActive(false);
            Player.SetActive(false);
            Invoke("OnComplete", 8.0f);

        }

        if (other.tag == "homeoutpoint")
        {
            SceneLevel6.SetActive(true);
            HomeOutPoint.SetActive(false);
            Player.SetActive(false);
            Invoke("OnComplete", 8.0f);
        }

        if (other.tag == "hide") {

            hidebtn.SetActive(true);
            currenthideobj = other.gameObject.transform.GetChild(0).gameObject;
        }
    }

    public void OnTriggerExit(Collider other)
    {
        if (other.tag == "hide")
        {

            hidebtn.SetActive(false);
        }
    }


    public void hiding() {

        if (!hidden)
        {
            currenthideobj.SetActive(true);
            Player.SetActive(false);
         //   PlayerControls.SetActive(false);
            Player.tag = "Untagged";
            hidden = true;
         }
        else {
            
            Player.SetActive(true);
            Player.tag = "Player";
           // PlayerControls.SetActive(true);
            currenthideobj.SetActive(false);
            hidden = false;
         }
    }


    public void CryTeacherBathroom()
    {
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        LighterPlayer.SetActive(false);
        TeacherCry.SetActive(true);
        AS.PlayOneShot(CryTeacherSFX);
        Invoke("OnComplete", 3.5f);
    }

    public void SceneLevel9wait()
    {
        TeacherWalkingLevel9.SetActive(false);
        SceneLevel9.SetActive(true);
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        Invoke("OnComplete", 13.0f);
    }

   

    public void OnComplete()
	{
        AS.PlayOneShot(levelincrement);
        GamePlayUI.Instance.levelincrement();
       // CompleteTaskPanel.SetActive(true);
       // Player.SetActive(false);
        //Invoke("ShowAd",1.5f);
        
        
    }


    public void ShowAd()
    {
        if (Ads == true)
        {
            NextButton.SetActive(true);
            //Advertisements.Instance.ShowInterstitial();
            Debug.Log("Task Ad");
            Ads = false;
            Time.timeScale = 0;
        }
    }



    public void OnNext()
    {
        Time.timeScale = 1;
        Ads = true;
        CompleteTaskPanel.SetActive(false);
        NextButton.SetActive(false);
        Player.SetActive(true);
    }

}