<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="Summary.aspx.cs"
    Inherits="PingSample._Summary" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Content ContentPlaceHolderID="MainContent"
             ID="BodyContent"
             runat="server" >

    <div id="app" >
        <table class="table" >
            <thead>
                <tr>
                    <th style="width: 30%">IP Address</th>
                    <th style="width: 30%">RoundtripTime</th>
                    <th style="width: 30%">Status</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="ip in ips">
                    <td>{{ ip.Ip }}</td>
                    <td>
                        <template v-if="ip.RoundtripTime">{{ ip.RoundtripTime }} ms</template> 
                    </td>
                    <td>
                        <span v-if="ip.Status === 'Success'" class="label label-success">Success</span>
                        <span v-if="ip.Status === 'Pinging'" class="label label-default">Pinging</span>
                        <span v-if="ip.Status === 'TimedOut'" class="label label-danger">TimedOut</span>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <script src="https://unpkg.com/vue@next"></script>
    <script>
        const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
        const app = createApp({
            setup() {
                
                const ping_api = "/ping/api.ashx";
                const ping_interval = 10000;  // ms
                
                // {
                //   IP
                //   RoundtripTime
                //   Status
                //   timeoutInstance
                // }
                const ips = ref(<%= JsonConvert.SerializeObject(IPs) %>.map(ip => ({ Ip: ip })));
                
                onMounted(() => {
                    ips.value.forEach( obj => interval_ping(obj));
                });
                
                const interval_ping = function(obj) {
                                        
                    fetch(ping_api, {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: obj.Ip
                    })  .then(response => response.json())
                        .then(data => {
                            obj.RoundtripTime = data.RoundtripTime;
                            obj.Status = data.Status;
                            
                            // setInterval
                            obj.timeoutInstance = setTimeout(() => {
                                obj.Status = "Pinging";
                                obj.RoundtripTime = "";
                                interval_ping(obj)
                            }, ping_interval);
                    });  
                    
                }
                
                return {
                    ips,
                }
            }
        });
        app.mount('#app');
    </script>

</asp:Content>
