using System.Collections;
using TMPro;
using UnityEngine;

public class texttypinganimation : MonoBehaviour
{
    public TMP_Text textMeshPro;
    public string fullText;
    public float typingSpeed = 0.1f;

    private int characterIndex = 0;

    private void Start()
    {
        if (textMeshPro == null)
        {
            Debug.LogError("TextMeshPro component is not assigned!");
            enabled = false;
            return;
        }

        if (fullText == null)
        {
            Debug.LogError("Full text is not set!");
            enabled = false;
            return;
        }

        textMeshPro.text = "";
        StartCoroutine(TypeText());
    }

    private IEnumerator TypeText()
    {
        while (characterIndex < fullText.Length)
        {
            textMeshPro.text += fullText[characterIndex];
            characterIndex++;
            yield return new WaitForSeconds(typingSpeed);
        }
    }
}
