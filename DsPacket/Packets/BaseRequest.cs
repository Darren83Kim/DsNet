﻿namespace DsPackets
{
    public class BaseRequest
    {
        public string token { get; set; } = string.Empty;
        public int sequence { get; set; } = 0;
        public string url { get; set; }

        public BaseRequest(string val)
        {
            url = val;
        }
    }
}
