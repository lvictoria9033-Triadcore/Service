using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;


namespace Triadcore.Service
{


    public class RunNowJobsQuickList : Triadcore.Base.QuickListBase
    {


        #region Properties
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Service.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.RunNowJobsQuickListItem> BindableRunJobsList
        {
            get
            {
                List<Triadcore.Service.RunNowJobsQuickListItem> listOut = new List<Triadcore.Service.RunNowJobsQuickListItem>();
                foreach (Triadcore.Service.RunNowJobsQuickListItem c in base.itemsQuickList)
                {
                    listOut.Add(c);
                }
                return listOut;
            }
        }
        #endregion


        #region LocalItems
        #endregion


        #region Constructors
        public RunNowJobsQuickList(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        #endregion


        #region Methods
        /// <summary>
        /// Gets the data from the datastore.
        /// </summary>
        public override void GetItems()
        {

            base.GetItems();

            System.Data.SqlClient.SqlDataReader sqlDr = null;
            int uid = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
            int lastUid = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;

            base.uidList.Clear();
            base.itemsQuickList.Clear();

            // Set the stored procedure parameters.
            try
            {
                base.itemsQuickList.Clear();
                base.sqlCommand = new System.Data.SqlClient.SqlCommand();
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "Service.GetRunNowJobs";
                #region Set Params
                #endregion
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred while setting the SqlCommand settings.  The exception is: " + ex.Message);
            }

            // Execute the stored procedure and loop through the result set.
            try
            {
                base.database.OpenConnection();
                base.sqlCommand.Connection = base.database.SQLConnection;
                sqlDr = base.sqlCommand.ExecuteReader();
                while (sqlDr.Read())
                {
                    uid = sqlDr.GetInt32(0);
                    Triadcore.Service.RunNowJobsQuickListItem item = new Triadcore.Service.RunNowJobsQuickListItem(uid);
                    item.JobId = uid;
                    item.JobScheduleId = sqlDr.GetInt32(1);
                    item.JobName = sqlDr.GetString(2);
                    item.ScheduleName = sqlDr.GetString(3);
                    item.ScheduleDescription = sqlDr.GetString(4);
                    item.IsRecurring = sqlDr.GetBoolean(5);
                    item.BaseDate = sqlDr.GetDateTime(6);
                    item.DateNextStart = sqlDr.GetDateTime(7);
                    item.ExecutablePath = sqlDr.GetString(8);
                    item.ParameterString = sqlDr.GetString(9).Trim();
                    item.RunAsUser = sqlDr.GetString(10);
                    item.RunAsPassword = sqlDr.GetString(11);
					item.LogStarts = sqlDr.GetBoolean(12);
					item.LogFinishes = sqlDr.GetBoolean(13);
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in RunJobsQuickList.GetItems() at Uid=" + uid.ToString() + " (last Uid=" + lastUid.ToString() + ") while retrieving Uid list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in RunJobsQuickListGetItems() at Uid=" + uid.ToString() + " (last Uid=" + lastUid.ToString() + ") while retrieving Uid list. The exception is: " + ex.Message);
            }
            finally
            {
                if (sqlDr != null)
                {
                    sqlDr.Close();
                }
                base.database.CloseConnectionConditionally();
            }

            base.PostGetItems();

            return;

        }

        /// <summary>
        /// Resets the criteria logic and values to nulls or equivalents.
        /// </summary>
        public override void ResetCriteria()
        {
            base.ResetCriteria();
            return;
        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.RunNowJobsQuickListItem newItem = new Triadcore.Service.RunNowJobsQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            this.itemsQuickList.Insert(0, newItem);
            return;
        }
        #endregion


    }


    public class RunNowJobsQuickListItem : Base.QuickListItemBase
    {

        public int JobId { get; set; } = -1;
        public int JobScheduleId { get; set; } = -1;
        public string JobName { get; set; } = string.Empty;
        public string ScheduleName { get; set; } = string.Empty;
        public string ScheduleDescription { get; set; } = string.Empty;
        public bool IsRecurring { get; set; } = false;
        public DateTime BaseDate { get; set; } = DateTime.MaxValue;
        public DateTime DateNextStart { get; set; } = DateTime.MaxValue;
        public string ExecutablePath { get; set; } = string.Empty;
        public string ParameterString { get; set; } = string.Empty;
        public string RunAsUser { get; set; } = string.Empty;
        public string RunAsPassword { get; set; } = string.Empty;
		public bool LogStarts { get; set; } = false;
		public bool LogFinishes { get; set; } = false;

		public RunNowJobsQuickListItem(int itemUid) : base(itemUid)
        {
        }

    }


}
