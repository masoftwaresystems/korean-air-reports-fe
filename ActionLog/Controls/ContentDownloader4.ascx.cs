namespace ContentDownloader4
{
    using System;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using System.Net;
    using System.Text;

    public class ContentDownloaderControl : System.Web.UI.UserControl
    {
		protected System.Web.UI.HtmlControls.HtmlGenericControl downloadContentContainer;

        private string mURL;

		private void InitializeComponent()
		{
		
		}
	
        public string URL
        {
            get
            {
                return this.mURL;
            }
            set
            {
                this.mURL = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                WebClient myWebClient = new WebClient();
                string tmpURL = URL;
                if (Request.RawUrl.IndexOf("?") > -1)
                {
                    URL += Request.RawUrl.Substring(Request.RawUrl.IndexOf("?"));
                } else {
                  if(URL.IndexOf("?") > -1) {
                    //
                  } else {
                    URL += "?x=1";
                  }
                }

                // Cookie Handler
                String[] cookieArr = Request.Cookies.AllKeys;
                for (int ccnt = 0; ccnt < cookieArr.Length; ccnt++)
                {
                    if((cookieArr[ccnt].Substring(0,1) != "_") && (cookieArr[ccnt].Substring(0,2) != "AS")) {
                      URL += "&cookie_" + cookieArr[ccnt] + "=" + Request.Cookies[cookieArr[ccnt]].Value.Replace("&","%26");
                    }
                }

                try
                {


                    /*	String[] arr1 = Request.Headers.AllKeys;

                        foreach(string s in arr1)
                        {
                            myWebClient.Headers.Add(s, Request.Headers[s]);
                        } */

                    /*URL = "http://portal.sfcvb.org" + URL;*/
                    URL = "http://10.1.21.179:8012" + URL;
                    
                    byte[] myDataBuffer = myWebClient.DownloadData(URL);

                    //downloadContentContainer.InnerHtml = URL;
                    string download = Encoding.UTF8.GetString(myDataBuffer);
                    downloadContentContainer.InnerHtml = download;
                }
                catch (Exception ex)
                {
                    downloadContentContainer.InnerHtml = "<!-- Error: " + ex.ToString() + "-->";
                }
            }

        }
    }


}