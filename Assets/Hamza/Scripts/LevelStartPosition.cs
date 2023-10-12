using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelStartPosition : MonoBehaviour
{
    // Start is called before the first frame update

    public GameObject Player;
    void Start()
    {
        if (PlayerPrefs.GetInt("Level") == 0)
        {
            //Player.transform.position = new Vector3(84.111f, -9.47f, -38.92f);
        }
        if (PlayerPrefs.GetInt("Level") == 1)
        {
            //Player.transform.position = new Vector3(-65.79f, 1.460734f, -6.06f);
        }
        if (PlayerPrefs.GetInt("Level") == 2)
        {
           // Player.transform.position = new Vector3(-1254.04f, -690.29f, 82.2f);
        }
        if (PlayerPrefs.GetInt("Level") == 3)
        {
            //Player.transform.position = new Vector3(2.68f, 3.65f, 17.67f);
        }
        if (PlayerPrefs.GetInt("Level") == 4)
        {
           // Player.transform.position = new Vector3(-34.7f, 0.5f, 75.28f);
        }
        if (PlayerPrefs.GetInt("Level") == 5)
        {
           // Player.transform.position = new Vector3(-17.8f, 1.06f, 101.29f);
        }
        if (PlayerPrefs.GetInt("Level") == 6)
        {
           // Player.transform.position = new Vector3(-17.8f, 1.06f, 59.86f);
        }
        if (PlayerPrefs.GetInt("Level") == 7)
        {
           // Player.transform.position = new Vector3(-116f, 1.06f, -33f);
        }
        if (PlayerPrefs.GetInt("Level") == 8)
        {
            //Player.transform.position = new Vector3(-101.2f, 2.29f, 56.8f);
        }
        if (PlayerPrefs.GetInt("Level") == 9)
        {
           // Player.transform.position = new Vector3(-114.8f, 2.29f, 15.3f);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
