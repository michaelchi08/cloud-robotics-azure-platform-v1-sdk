using System;


namespace CloudRoboticsFX.Worker
{
    class RbEventMessageLog
    {
        public string MessageType { set; get; }
        public DateTime SendUtcDateTime { set; get; }
        public object Messages { set; get; } 
    }
}