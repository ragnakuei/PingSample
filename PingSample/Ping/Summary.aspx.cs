﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PingSample
{
    public partial class _Summary : Page
    {
        public string[] IPs { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            IPs = new[]
                  {
                      "8.8.8.8",
                      "8.8.4.4",
                      "1.1.1.1",
                      "1.0.0.1",
                      "208.67.222.222",
                      "208.67.220.220",
                      "8.26.56.26",
                      "8.20.247.20",
                      "9.9.9.9",
                      "149.112.112.112",
                      "168.95.1.1",
                      "168.95.192.1",
                      "139.175.1.1",
                      "61.64.127.1",
                      "61.64.127.2",
                      "211.78.215.137",
                      "211.78.215.200",
                      "101.101.101.101",
                      "101.102.103.104",
                      "140.112.254.4",
                      "140.112.2.2",
                      "140.114.63.1",
                      "140.114.64.1",
                      "140.113.1.1",
                      "140.113.6.2",
                      "140.113.250.135",
                      "163.28.113.1",
                      "163.28.112.1",
                      "140.115.1.31",
                      "140.115.19.42",
                  };
        }
    }
}
