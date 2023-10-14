using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class splashhandler : MonoBehaviour
{
    public void loadscene()
    {
        SceneManager.LoadScene(1);
    }
    public void showbanner()
    {
        AdsManager.instance?.ShowBanner();
    }
    // Start is called before the first frame update
    void Start()
    {
        Invoke(nameof(showbanner), 4.5f);
        Invoke(nameof(loadscene), 5f);
    }

    
}
