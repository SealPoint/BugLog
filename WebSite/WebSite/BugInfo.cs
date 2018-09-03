using System;


namespace WebSite
{
    public class BugInfo
    {
        private int _id;
        private string _title;
        private string _description;
        private string _status;

        public BugInfo (int aID,
                        string aTitle,
                        string aDescription,
                        string aStatus)
        {
            _id = aID;
            _title = aTitle;
            _description = aDescription;
            _status = aStatus;
        }

        public int ID
        {
            get { return _id; }
        }

        public string Title
        {
            get { return _title; }
            set { _title = value; }
        }

        public string Description
        {
            get { return _description; }
            set { _description = value; }
        }

        public string Status
        {
            get { return _status; }
            set { _status = value; }
        }
    }
}
