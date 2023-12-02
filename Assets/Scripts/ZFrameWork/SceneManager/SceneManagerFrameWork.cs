using System.Collections;
using UnityEngine;
using UnityEngine.Events;

namespace ZFramework
{
    public class ZFrameWorkSceneManager : BaseSingleton<ZFrameWorkSceneManager>
    {
        public void LoadScene(string sceneName, UnityAction callBack = null)
        {
            UnityEngine.SceneManagement.SceneManager.LoadScene(sceneName);
            callBack?.Invoke();
        }

        public void LoadSceneAsync(string sceneName, UnityAction callBack = null)
        {
            MonoManager.Instance.StartCoroutineFrameWork(LoadSceneAsyncCoroutine(sceneName, callBack));
        }

        private IEnumerator LoadSceneAsyncCoroutine(string sceneName, UnityAction callBack)
        {
            AsyncOperation ao = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(sceneName);
            while (!ao.isDone)
            {
                EventCenter.Instance.TriggerEvent<float>("进度条更新", ao.progress);
                yield return ao;
            }

            callBack?.Invoke();
        }
    }
}