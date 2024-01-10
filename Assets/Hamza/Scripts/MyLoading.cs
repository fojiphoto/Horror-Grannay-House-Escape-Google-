using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;

public class MyLoading : MonoBehaviour
{
    // Start is called before the first frame update
    public Image loadingImage;
    void Start()
    {
        loadingImage.DOFillAmount(1, 12).SetEase(Ease.Linear);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
