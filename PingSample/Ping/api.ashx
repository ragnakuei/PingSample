<%@ WebHandler Language="C#" Class="api" %>

using System.Web;
using Newtonsoft.Json;

public class api : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        var ip = new System.IO.StreamReader(context.Request.InputStream).ReadToEnd();

        var ping  = new System.Net.NetworkInformation.Ping();
        var reply = ping.Send(ip);

        context.Response.ContentType = "application/json";
        context.Response.Write(JsonConvert.SerializeObject(new
                                                           {
                                                               Address       = reply.Address?.ToString(),
                                                               RoundtripTime = reply.RoundtripTime,
                                                               Status        = reply.Status.ToString(),
                                                           }));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
