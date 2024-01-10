using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class splashhandler : MonoBehaviour
{
    public void loadscene()
    {
        SceneManager.LoadScene("GUI");
    }
    public void showbanner()
    {
        //nadeem
        CASAds.instance.ShowBanner(CAS.AdPosition.TopCenter);
        //AdsManager.instance?.ShowBanner();
    }
    // Start is called before the first frame update
    void Start()
    {
        //Invoke(nameof(showbanner), 13f);
        Invoke(nameof(loadscene), 12f);
    }

    
}
