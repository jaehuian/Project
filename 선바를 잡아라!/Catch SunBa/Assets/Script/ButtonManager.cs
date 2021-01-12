using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//장면 로드
using UnityEngine.SceneManagement;
public class ButtonManager : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void StartButtonClick()
    {
        //게임화면 불러오기
        SceneManager.LoadScene("Game");
        Debug.Log("Button Click");
    }
}
