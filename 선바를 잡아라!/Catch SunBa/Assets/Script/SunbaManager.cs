using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using System.Linq;

public class SunbaManager : MonoBehaviour
{
    public Canvas canvas;
    public GameObject Sunba, SunbaB, SunbaS, SunbaAL, SunbaAN;
    public bool GameOver = false,  startBlind = false,stopTime=false;
    GameObject[] checkSunba = new GameObject[8];
    GameObject gameoverImage;
    RectTransform BlindB,BlindF;
    Vector2 BlindB_origin_pos, BlindF_origin_pos;

    private void Awake()
    {
        //선바 배치 가능 여부 초기화
        System.Array.Clear(checkSunba, 0, 8);
        
        gameoverImage = GameObject.Find("EventCanvas").transform.Find("GameOver").gameObject;
        gameoverImage.SetActive(false);

        BlindB = GameObject.Find("BlindB").gameObject.GetComponent<RectTransform>();
        BlindB_origin_pos = new Vector2(-750, -140);
        BlindF=GameObject.Find("Flower").gameObject.GetComponent<RectTransform>();
        BlindF_origin_pos = new Vector2(0, -1100);
    }
    // Start is called before the first frame update
    void Start()
    {
        if(GameOver!=true)
            StartCoroutine("spawn_Sunba");
    }

    // Update is called once per frame
    void Update()
    {
        //게임오버
        if (GameOver == true)
        {
            //선바 소환 중지
            StopCoroutine("spawn_Sunba");
            //남은 선바 파괴
            Destroy(GameObject.FindWithTag("Sunba"));
            //시야가림(꽃) 원위치
            BlindF.anchoredPosition = new Vector2(0, 800);
            //시야가림(벌) 원위치
            BlindB.anchoredPosition = new Vector2(750, -140);

            gameoverImage.SetActive(true);
            Invoke("check_MouseEvent", 2);
        }
        //벌꿀선바 이벤트
        else if(startBlind==true)
        {
            StartCoroutine("Blind_Animation");
            StopCoroutine("Blind_Animation");
        }
        else if(stopTime==true)
        {

        }
    }
    //선바 소환
    IEnumerator spawn_Sunba()
    {
        int spawnTime;
        spawnTime = Random.Range(1, 3);

        yield return new WaitForSeconds(spawnTime);

        //선바 배치 위치
        int randomPosition = Random.Range(0, 8);
        //위치 사용 가능 여부 체크
        randomPosition=check_Position(randomPosition);

        //사용가능한 위치가 있을 경우
        if (randomPosition != -1)
        {
            //선바 오브젝트 생성
            GameObject newSunba = choose_Sunba(); 
            //캔버스 자식 오브젝트로 설정
            newSunba.transform.SetParent(canvas.transform, false);

            //선바 위치,크기 정보
            RectTransform newSunba_rect = newSunba.GetComponent<RectTransform>();
            //선바 크기 설정
            newSunba_rect.sizeDelta = new Vector2(0, 0);
            //선바 위치 설정
            if (randomPosition < 4)
            {
                newSunba_rect.anchoredPosition = new Vector2(-450 + 250 * randomPosition, 400);
            }
            else
            {
                newSunba_rect.anchoredPosition = new Vector2(-400 + 250 * (randomPosition - 4), 150);
            }

            //현재 위치 사용중
            checkSunba[randomPosition] = newSunba;
        }
        StartCoroutine("spawn_Sunba");
    }
    //소환할 선바 종류
    GameObject choose_Sunba()
    {
        int random = Random.Range(1, 101);

        if(random>=30)
            return Instantiate(Sunba) as GameObject;
        else if(random>=20)
            return Instantiate(SunbaB) as GameObject;
        else if(random>=15)
            return Instantiate(SunbaS) as GameObject;
        else if (random >= 10)
            return Instantiate(SunbaAL) as GameObject;
        else
            return Instantiate(SunbaAN) as GameObject;
    }
    //선바 소환 가능 여부
    int check_Position(int index)
    {
        int rePosition, nullCount=0;

        //해당 위치 사용 가능 여부
        if (checkSunba[index] != null)
        {
            for (int i = 0; i < 8; i++)
            {
                if (checkSunba[i] == null)
                {
                    nullCount++;
                }
            }
            //사용 가능한 위치가 존재하지 않을 경우
            if (nullCount == 0)
                return -1;
            //사용 가능한 위치 탐색
            else
            {
                do
                {
                    rePosition = Random.Range(0, 8);
                } while (checkSunba[rePosition] != null);
                return rePosition;
            }
        }
        else if (checkSunba[index] == null)
        {
            return index;
        }
        return -1;
    }

    //마우스 입력 체크
    void check_MouseEvent()
    {
        if(Input.GetMouseButton(0))
        {
            SceneManager.LoadScene("MainMenu");
        }
    }

    //벌꿀선바 애니메이션(시야방해)
    IEnumerator Blind_Animation()
    {
        BlindB.anchoredPosition = Vector3.MoveTowards(BlindB.anchoredPosition, BlindB_origin_pos, 1.8f);
        BlindF.anchoredPosition = Vector3.MoveTowards(BlindF.anchoredPosition, BlindF_origin_pos, 2.1f);

        if ((BlindB.anchoredPosition.x <=-730)&& (BlindF.anchoredPosition.y <= -1080))
        {
            BlindB.anchoredPosition = new Vector2(750, -140);
            BlindF.anchoredPosition = new Vector2(0, 800);
            startBlind = false;
        }
        yield return null;
    }
}
