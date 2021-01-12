using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SoundManager : MonoBehaviour
{
    AudioSource sound;
    public AudioClip bee;
    public AudioClip alcohol;
    public AudioClip sunba;
    public AudioClip angry;

    private void Awake()
    {
        sound = this.GetComponent<AudioSource>();
    }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void play_bee()
    {
        sound.PlayOneShot(bee);
    }

    public void play_alcohol()
    {
        sound.PlayOneShot(alcohol);
    }
    public void play_sunba()
    {
        sound.PlayOneShot(sunba);
    }
    public void play_angry()
    {
        sound.PlayOneShot(angry);
    }
}
