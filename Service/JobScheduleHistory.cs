/******************************************************************************************************************************************************
* Name        : JobScheduleHistory.cs
* Purpose     : Provides JobScheduleHistory support.
* Create Date : 2026.10.30
* Created By  : Triadcore (ACB)
******************************************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Triadcore;


namespace Triadcore.Service
{

	
	public class JobScheduleHistoriesQuickList : Triadcore.Base.QuickListBase
    {


        #region Properties
        /// <summary>
        /// Gets or sets the grouping logic for grouping filtering criteria.
        /// </summary>
        public Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic GroupingLogic
        {
            get
            {
                return this.groupingLogic;
            }
            set
            {
                this.groupingLogic = value;
            }
        }
        /// <summary>
		/// Fkey to Service.JobSchedules.
		/// Fkey
		/// </summary>
		public int? JobScheduleId
		{
			get
			{
				return this.jobScheduleId;
			}
			set
			{
				if (this.jobScheduleId != value)
				{
					this.jobScheduleId = value;
				}
			}
		}
		/// <summary>
		/// ExecuteDateTimeStart compare logic for filtering.
		/// </summary>
		public string ExecuteDateTimeStartCompareLogic
		{
			get
			{
				return this.executeDateTimeStartCompareLogic;
			}
			set
			{
				this.executeDateTimeStartCompareLogic = value;
			}
		}
		/// <summary>
		/// The date and time the job executed based on this schedule.
		/// </summary>
		public DateTime? ExecuteDateTimeStart
		{
			get
			{
				return this.executeDateTimeStart;
			}
			set
			{
				if (this.executeDateTimeStart != value)
				{
					this.executeDateTimeStart = value;
				}
			}
		}
		/// <summary>
		/// ExecuteDateTimeEnd compare logic for filtering.
		/// </summary>
		public string ExecuteDateTimeEndCompareLogic
		{
			get
			{
				return this.executeDateTimeEndCompareLogic;
			}
			set
			{
				this.executeDateTimeEndCompareLogic = value;
			}
		}
		/// <summary>
		/// The date and time the job finished.
		/// </summary>
		public DateTime? ExecuteDateTimeEnd
		{
			get
			{
				return this.executeDateTimeEnd;
			}
			set
			{
				if (this.executeDateTimeEnd != value)
				{
					this.executeDateTimeEnd = value;
				}
			}
		}
		/// <summary>
		/// The numeric result code returned from the executable at the end of execution.
		/// </summary>
		public int? ResultCode
		{
			get
			{
				return this.resultCode;
			}
			set
			{
				if (this.resultCode != value)
				{
					this.resultCode = value;
				}
			}
		}
		/// <summary>
		/// ResultText compare logic for filtering.
		/// </summary>
		public string ResultTextCompareLogic
		{
			get
			{
				return this.resultTextCompareLogic;
			}
			set
			{
				this.resultTextCompareLogic = value;
			}
		}
		/// <summary>
		/// The result text/message returned from the executable at the end of execution.
		/// </summary>
		public string ResultText
		{
			get
			{
				return this.resultText;
			}
			set
			{
				if (this.resultText != value)
				{
					this.resultText = value;
				}
			}
		}
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Base.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.JobScheduleHistoriesQuickListItem> BindableJobScheduleHistoriesList
        {
            get
            {
                List<Triadcore.Service.JobScheduleHistoriesQuickListItem> listOut = new List<Triadcore.Service.JobScheduleHistoriesQuickListItem>();
                foreach (Triadcore.Service.JobScheduleHistoriesQuickListItem c in base.itemsQuickList)
                {
                    listOut.Add(c);
                }
                return listOut;
            }
        }
        /// <summary>
        /// ACB build date.
        /// </summary>
        public string AcbBuildDate
        {
            get
            {
                return this.acbBuildDate;
            }
        }
        #endregion


        #region LocalItems
        private Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic groupingLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL;
        private int? jobScheduleId = null;  // Fkey
		private string executeDateTimeStartCompareLogic = null; 
		private DateTime? executeDateTimeStart = null;
		private string executeDateTimeEndCompareLogic = null; 
		private DateTime? executeDateTimeEnd = null;
		private int? resultCode = null;
		private string resultTextCompareLogic = null; 
		private string resultText = null;
        //
        protected string acbBuildDate = "2026.10.30";
        #endregion


        #region Constructors
        public JobScheduleHistoriesQuickList(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleHistories]";
                base.sqlCommand.CommandTimeout = 0;

                #region Set stored procedure parameters
                if (this.groupingLogic == Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL)
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", this.groupingLogic.ToString());
                }
			    base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", System.DBNull.Value);
			    if (base.createDate != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@CreateDate", base.createDate);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value);
				}
				// Fkey
				if (base.createUserId != null && base.createUserId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@CreateUserId", base.createUserId); // Fkey
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value); // Fkey
				}
				if (base.updateDate != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@UpdateDate", base.updateDate);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value);
				}
				// Fkey
				if (base.updateUserId != null && base.updateUserId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId); // Fkey
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value); // Fkey
				}
				if (base.active != null && base.active != Triadcore.ClassLibrary.Utilities.TriStateBoolean.Undefined)
				{
					base.sqlCommand.Parameters.AddWithValue("@Active", base.active);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
				}
				// Fkey
				if (this.jobScheduleId != null && this.jobScheduleId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", this.jobScheduleId); // Fkey
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value); // Fkey
				}
				if (this.executeDateTimeStartCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@executeDateTimeStartCompareLogic", this.executeDateTimeStartCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@executeDateTimeStartCompareLogic", System.DBNull.Value);
				}
				if (this.executeDateTimeStart != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", this.executeDateTimeStart);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", System.DBNull.Value);
				}
				if (this.executeDateTimeEndCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@executeDateTimeEndCompareLogic", this.executeDateTimeEndCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@executeDateTimeEndCompareLogic", System.DBNull.Value);
				}
				if (this.executeDateTimeEnd != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", this.executeDateTimeEnd);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", System.DBNull.Value);
				}
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserNameCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserName", System.DBNull.Value);  // forced DbNull
				if (this.resultCode != null && this.resultCode != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultCode", this.resultCode);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value);
				}
				if (this.resultTextCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@resultTextCompareLogic", this.resultTextCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@resultTextCompareLogic", System.DBNull.Value);
				}
				if (this.resultText != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultText", this.resultText);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultText", System.DBNull.Value);
				}
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
                    Triadcore.Service.JobScheduleHistoriesQuickListItem item = new Triadcore.Service.JobScheduleHistoriesQuickListItem(uid);
                    item.CreateDate = sqlDr.GetDateTime(1);
					item.CreateUserId = sqlDr.GetInt32(2); // Fkey
					item.CreateUserName = sqlDr.GetString(3);  // Fkey alias to CreateUserId
					item.UpdateDate = sqlDr.GetDateTime(4);
					item.UpdateUserId = sqlDr.GetInt32(5); // Fkey
					item.UpdateUserName = sqlDr.GetString(6);  // Fkey alias to UpdateUserId
					item.Active = sqlDr.GetBoolean(7);
					item.JobScheduleId = sqlDr.GetInt32(8); // Fkey
					item.JobScheduleName = sqlDr.GetString(9);  // Fkey alias to JobScheduleId
					item.ExecuteDateTimeStart = sqlDr.GetDateTime(10);
					item.ExecuteDateTimeEnd = sqlDr.GetDateTime(11);
					if (!sqlDr.IsDBNull(14))
					{
						item.ResultCode = sqlDr.GetInt32(14);
					}
					else
					{
						item.ResultCode = null;
					}
					if (!sqlDr.IsDBNull(15))
					{
						item.ResultText = sqlDr.GetString(15);
					}
					else
					{
						item.ResultText = null;
					}
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                    lastUid = uid;
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistoriesQuickList.GetItems() while retrieving data list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistoriesQuickList.GetItems() while retrieving data list. The exception is: " + ex.Message);
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

            this.groupingLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL;
            this.jobScheduleId = null;  // Fkey
			this.executeDateTimeStartCompareLogic = null;
			this.executeDateTimeStart = null;
			this.executeDateTimeEndCompareLogic = null;
			this.executeDateTimeEnd = null;
			this.resultCode = null;
			this.resultTextCompareLogic = null;
			this.resultText = null;

            return;

        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.JobScheduleHistoriesQuickListItem newItem = new Triadcore.Service.JobScheduleHistoriesQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            this.itemsQuickList.Insert(0, newItem);
        }
        #endregion


    }


	public class JobScheduleHistoriesQuickListItem : Triadcore.Base.QuickListItemBase
    {

        /// <summary>
	    /// The JobScheduleHistory unique identifier.
	    /// </summary>    
        public int JobScheduleHistoryId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// Fkey to Service.JobSchedules.
		/// </summary>
		public int? JobScheduleId
		{
			get;
			set;
		}
		/// <summary>
		/// JobScheduleId name.
		/// </summary>
		public string JobScheduleName
		{
			get;
			set;
		}
		/// <summary>
		/// The date and time the job executed based on this schedule.
		/// </summary>
		public DateTime? ExecuteDateTimeStart
		{
			get;
			set;
		}
		/// <summary>
		/// The date and time the job finished.
		/// </summary>
		public DateTime? ExecuteDateTimeEnd
		{
			get;
			set;
		}
		/// <summary>
		/// The numeric result code returned from the executable at the end of execution.
		/// </summary>
		public int? ResultCode
		{
			get;
			set;
		}
		/// <summary>
		/// The result text/message returned from the executable at the end of execution.
		/// </summary>
		public string ResultText
		{
			get;
			set;
		}
        /// <summary>
        /// ACB build date.
        /// </summary>
        public string AcbBuildDate
        {
            get
            {
                return "2026.10.30";
            }
        }

        public JobScheduleHistoriesQuickListItem(int itemUid) : base(itemUid)
        {
        }

    }



	public class JobScheduleHistory : Triadcore.Base.ItemBase
    {


        #region Properties
        /// <summary>
        /// Gets the item unique ID in the datastore.
        /// </summary>
        public int JobScheduleHistoryId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// Fkey to Service.JobSchedules..
		/// Fkey to Service.JobSchedules.
		/// </summary>
		public int JobScheduleId
		{
			get
			{
				return this.jobScheduleId;
			}
			set
			{
				if (this.jobScheduleId != value)
				{
					this.jobScheduleId = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The foreign key alias of foreign key JobScheduleId.
		/// </summary>
		public string JobScheduleName
		{
			get
			{
				return (this.jobScheduleName == null ? "" : this.jobScheduleName);
			}
		}
		/// <summary>
		/// The date and time the job executed based on this schedule..
		/// </summary>
		public DateTime ExecuteDateTimeStart
		{
			get
			{
				return this.executeDateTimeStart;
			}
			set
			{
				if (this.executeDateTimeStart != value)
				{
					this.executeDateTimeStart = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The date and time the job finished..
		/// </summary>
		public DateTime ExecuteDateTimeEnd
		{
			get
			{
				return this.executeDateTimeEnd;
			}
			set
			{
				if (this.executeDateTimeEnd != value)
				{
					this.executeDateTimeEnd = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The user account the job ran on..
		/// </summary>
		public string ExecuteUserName
		{
			get
			{
				return this.executeUserName;
			}
			set
			{
				if (this.executeUserName != value)
				{
					this.executeUserName = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The parameters passed on to the executable by the executing client at the time of execution..
		/// </summary>
		public string ExecuteParams
		{
			get
			{
				return this.executeParams;
			}
			set
			{
				if (this.executeParams != value)
				{
					this.executeParams = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The numeric result code returned from the executable at the end of execution..
		/// </summary>
		public int? ResultCode
		{
			get
			{
				return this.resultCode;
			}
			set
			{
				if (this.resultCode != value)
				{
					this.resultCode = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The result text/message returned from the executable at the end of execution..
		/// </summary>
		public string ResultText
		{
			get
			{
				return this.resultText;
			}
			set
			{
				if (this.resultText != value)
				{
					this.resultText = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// Free-text notes..
		/// </summary>
		public string Note
		{
			get
			{
				return this.note;
			}
			set
			{
				if (this.note != value)
				{
					this.note = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
        /// <summary>
        /// ACB build date.
        /// </summary>
        public string AcbBuildDate
        {
            get
            {
                return this.acbBuildDate;
            }
        }
        #endregion


        #region Local Items
        private int jobScheduleId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private string jobScheduleName = null; // Fkey alias to JobScheduleId
		private DateTime executeDateTimeStart = DateTime.Now;
		private DateTime executeDateTimeEnd = DateTime.Now;
		private string executeUserName = "";
		private string executeParams = "";
		private int? resultCode = null;
		private string resultText = null;
		private string note = null;
		//
		private int jobScheduleIdOld = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private DateTime executeDateTimeStartOld = DateTime.Now;
		private DateTime executeDateTimeEndOld = DateTime.Now;
		private string executeUserNameOld = "";
		private string executeParamsOld = "";
		private int? resultCodeOld = null;
		private string resultTextOld = null;
		private string noteOld = null;
        //
        protected string acbBuildDate = "2026.10.30";
        #endregion


        #region Constructors
        public JobScheduleHistory(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public JobScheduleHistory(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobScheduleHistoryId) : base(dbObject, user, jobScheduleHistoryId)
        {
        }        #endregion


        #region Methods
        /// <summary>
        /// Gets the item data from the datastore.
        /// </summary>
        public override void GetItem()
        {

            base.GetItem();

            if (base.isNew)
            {
                return;
            }

            System.Data.SqlClient.SqlDataReader sqlDr = null;

            try
            {

                base.database.OpenConnection();

                base.sqlCommand = new System.Data.SqlClient.SqlCommand();
                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleHistories]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);  // Fkey
				base.sqlCommand.Parameters.AddWithValue("@CreateUserName", System.DBNull.Value); // Fkey alias to CreateUserId
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);  // Fkey
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserName", System.DBNull.Value); // Fkey alias to UpdateUserId
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStartCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEndCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserNameCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserName", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ResultTextCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@ResultText", System.DBNull.Value); // forced DB Null
			    #endregion

                // Execute the stored procedure
                sqlDr = base.sqlCommand.ExecuteReader();

                // Get data from resultset
                if (sqlDr.HasRows)
                {
                    sqlDr.Read();
                    base.itemUid = sqlDr.GetInt32(0);
                    base.createDate = sqlDr.GetDateTime(1);
					base.createUserId = sqlDr.GetInt32(2); // Fkey
					base.createUserName = sqlDr.GetString(3);  // Fkey alias to CreateUserId
					base.updateDate = sqlDr.GetDateTime(4);
					base.updateUserId = sqlDr.GetInt32(5); // Fkey
					base.updateUserName = sqlDr.GetString(6);  // Fkey alias to UpdateUserId
					base.active = sqlDr.GetBoolean(7);
					this.jobScheduleId = sqlDr.GetInt32(8); // Fkey
					this.jobScheduleName = sqlDr.GetString(9);  // Fkey alias to JobScheduleId
					this.executeDateTimeStart = sqlDr.GetDateTime(10);
					this.executeDateTimeEnd = sqlDr.GetDateTime(11);
					this.executeUserName = sqlDr.GetString(12);
					this.executeParams = sqlDr.GetString(13);
					if (!sqlDr.IsDBNull(14))
					{
						this.resultCode = sqlDr.GetInt32(14);
					}
					else
					{
						this.resultCode = null;
					}
					if (!sqlDr.IsDBNull(15))
					{
						this.resultText = sqlDr.GetString(15);
					}
					else
					{
						this.resultText = null;
					}
					if (!sqlDr.IsDBNull(16))
					{
						this.note = sqlDr.GetString(16);
					}
					else
					{
						this.note = null;
					}
                    base.isValid = true;
                }
                else
                {
                    base.isValid = false;
                }
                sqlDr.Close();
                base.database.CloseConnectionConditionally();

                base.isDirty = false;

                // Backup data to local data items.
                this.BackupValues();

                if (base.isValid)
                {
                    base.ItemSuccessfullyRetrieved();
                }

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.GetItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.GetItem(). The exception is: " + ex.Message);

            }
            finally
            {

                if (sqlDr != null && !sqlDr.IsClosed )
                {
                    sqlDr.Close();
                }
                base.database.CloseConnectionConditionally();

            }

            if (base.isValid)
            {
                // no-op
            }

            base.PostGetItem();

            return;

        }

        /// <summary>
        /// Updates the data item in the datastore.
        /// </summary>
        public override void UpdateItem()
        {

            base.UpdateItem();

            if (!this.ValidateItem())
            {
                StringBuilder msg = new StringBuilder();
                int cnt = 0;
                msg.Append("Validation Error: ");
                if (this.errorMessages.Count > 0)
                {
                    foreach (string s in this.errorMessages)
                    {
                        msg.Append(" [" + cnt.ToString() + "] " + s);
                    }
                }
                else
                {
                    msg.Append(" Data item failed to validate.");
                }
                throw new Exception(msg.ToString().Trim());
            }

            try
            {

                base.sqlCommand = new System.Data.SqlClient.SqlCommand();

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[UpdateJobScheduleHistory]";
			
                #region Set stored procedure parameters
                if (!base.isNew)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                // Foreign key
				if (this.jobScheduleId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", this.jobScheduleId);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
				}
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", this.executeDateTimeStart);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", this.executeDateTimeEnd);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserName", this.executeUserName);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteParams", this.executeParams);
				if (this.resultCode == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultCode", this.resultCode);
				}
				if (this.resultText == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultText", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@ResultText", this.resultText);
				}
				if (this.note == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Note", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Note", this.note);
				}
			    #endregion

                // Execute stored procedure.
                int lastUpdatedId = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns Id of last updated/inserted data item

                if (base.isNew)
                {
                    base.itemUid = lastUpdatedId;
                    base.isNew = false;
                }

                if (!base.isNew && lastUpdatedId != base.itemUid)
                {
                    throw new Exception("WARNING! The Item Uid of the last record updated is not the same as the Item Uid of the current item.");
                }

                base.ItemSuccessfullyUpdated();

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.UpdateItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.UpdateItem() when attempting to retrieve data. The exception is: " + ex.Message);

            }
            finally
            {

                base.database.CloseConnectionConditionally();

            }

            // Get same item again from data store to ensure that the properties have the actual data in data store.
            try
            {
                this.GetItem();
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.UpdateItem() when attempting to use method GetItem() to refresh the data after an apparent successful update. The exception is: " + ex.Message);
            }

            base.PostUpdateItem();

            return;

        }

        /// <summary>
        /// Sets the Active indicator in the datastore.
        /// </summary>
        public override void SetActiveIndicator(bool active)
        {

            base.SetActiveIndicator(active);

            base.sqlCommand = new System.Data.SqlClient.SqlCommand();
            int indicator = 1;

            if (active)
            {
                indicator = 1;
            }
            else
            {
                indicator = 0;
            }

            try
            {

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[SetJobScheduleHistoryActivation]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@Active", indicator);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);

                // Execute stored procedure.
                int lastUpdatedId = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns PK Id of last updated data item

                if (base.isNew)
                {
                    base.itemUid = lastUpdatedId;
                    base.isNew = false;
                }

                if (!base.isNew && lastUpdatedId != base.itemUid)
                {
                    throw new Exception("WARNING! The Item Uid of the last record activated/deactivated is not the same as the ItemUid of the current item.");
                }

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.SetActiveIndicator(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.SetActiveIndicator(). The exception is: " + ex.Message);

            }
            finally
            {

                base.database.CloseConnectionConditionally();

            }

            // Get same item again from datastore to ensure that the properties have the actual data in datastore.
            try
            {
                this.GetItem();
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.SetActiveIndicator(bool) when attempting to use method GetItem() to refresh the data after an apparent successful update to set the item ACTIVE flag. The exception is: " + ex.Message);
            }

            base.PostSetActiveIndicator(active);

            return;

        }
      
        /// <summary>
        /// Deleltes the item from the datastore.  If the item has a reference constraint and cannot be delete, it's set to Inactive.
        /// </summary>
        public override void DeleteItem()
        {

            base.DeleteItem();

            base.sqlCommand = new System.Data.SqlClient.SqlCommand();
            int returnCode = 0;
            string deleteNote = "JobScheduleId=" + this.jobScheduleId.ToString() + ".";

            if (base.isNew)
            {
                throw new Exception("Cannot delete a new data item.");
            }

            // Delete the data item.
            try
            {

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[DeleteJobScheduleHistory]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@Note", deleteNote);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);
			    #endregion

                // Execute stored procedure.
                returnCode = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns an error code. 0=no error.

                if (returnCode == 0)
                {
                    base.ItemSuccessfullyDeleted();
                }
                else
                {
                    throw new Exception("WARNING! The attempt to delete, the data item returned a non-zero return code.  The return code is: " + returnCode.ToString() + ".");
                }

            }
            catch (SqlException sqlEx)
            {

                // Check if there was a reference constraint error.
                if (sqlEx.Number == 547)
                {
                    returnCode = 1;
                }
                else
                {
                    throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.DeleteItem().  The error code is: " + sqlEx.Number.ToString() + ". The execption is: " + sqlEx.Message);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.DeleteItem(). The exception is: " + ex.Message);

            }
            finally
            {

                base.database.CloseConnectionConditionally();

            }

            // The data item could not be deleted because other data contains a reference to it.
            // Set the data item as INACTIVE.
            if (returnCode == 1)
            {
                try
                {
                    this.SetActiveIndicator(false);
                    base.clientMessages.Add("The data item could not be deleted in the database because other data contains a reference to it. The data was instead set to an INACTIVE status in the database.");
                }
                catch (Exception ex)
                {
                    throw new Exception("The data item could not be deleted in the database because other data contains a reference to it. An attempt was made to set the data to an INACTIVE status in the database but an error occured:" + ex.Message);
                }
            }

            return;

        }

        /// <summary>
        /// Ensures that the item data is valid.
        /// Failed validation error messages are written to the ClientMessages{} property.
        /// </summary>
        /// <returns>True if the data is valid, False otherwise.</returns>
        public override bool ValidateItem()
        {

            bool isValid = true;

            // JobScheduleId - Fkey
			if ((this.jobScheduleId == Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)) // Fkey
			{
				isValid = false;
				base.errorMessages.Add("Field [JobScheduleId] must be specified.");
			}
			if (this.executeDateTimeStart == null)
			{
				isValid = false;
				base.errorMessages.Add("Field [ExecuteDateTimeStart] cannot be null.");
			}
			if (this.executeDateTimeEnd == null)
			{
				isValid = false;
				base.errorMessages.Add("Field [ExecuteDateTimeEnd] cannot be null.");
			}
        
            return isValid;

        }

        /// <summary>
        /// Searches for an existing item that already has the same unique name.
        /// </summary>
        /// <returns>True if the item already exists, False otherwise.</returns>
        public override bool IsDuplicate()
        {

            base.IsDuplicate();

            bool dupeFound = false;
            System.Data.SqlClient.SqlDataReader sqlDr = null;

            try
            {

                base.database.OpenConnection();

                base.sqlCommand = new System.Data.SqlClient.SqlCommand();
                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleHistories]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", System.DBNull.Value);
			    base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStartCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEndCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserNameCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ExecuteUserName", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ResultTextCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@ResultText", System.DBNull.Value);

                // Execute the stored procedure
                sqlDr = base.sqlCommand.ExecuteReader();

                // Get data from resultset
                if (sqlDr.HasRows)
                {
                    while (sqlDr.Read())
                    {
                        if (base.itemUid != sqlDr.GetInt32(0))
                        {
                            base.duplicateId = sqlDr.GetInt32(0);
                            dupeFound = true;
                            break;
                        }
                    }
                } // if (sqlDr.HasRows)

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.IsDuplicate(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.IsDuplicate(). The exception is: " + ex.Message);

            }
            finally
            {

                if (sqlDr != null)
                {
                    sqlDr.Close();
                }
                base.database.CloseConnectionConditionally();

            }

            return dupeFound;

        }

        /// <summary>
        /// Writes data to backup local data items for later retrieval of the original data values.
        /// </summary>
        public override void BackupValues()
        {

            base.BackupValues();

            this.jobScheduleIdOld = this.jobScheduleId; // Fkey
			this.executeDateTimeStartOld = this.executeDateTimeStart;
			this.executeDateTimeEndOld = this.executeDateTimeEnd;
			this.executeUserNameOld = this.executeUserName;
			this.executeParamsOld = this.executeParams;
			this.resultCodeOld = this.resultCode;
			this.resultTextOld = this.resultText;
			this.noteOld = this.note;

            return;

        }

        /// <summary>
        /// Restores the data that has not been saved to the datastore to their original values.
        /// </summary>
        public override void UndoChanges()
        {

            if (base.isDirty)
            {
                base.UndoChanges();
                this.jobScheduleId = this.jobScheduleIdOld; // Fkey
				this.executeDateTimeStart = this.executeDateTimeStartOld;
				this.executeDateTimeEnd = this.executeDateTimeEndOld;
				this.executeUserName = this.executeUserNameOld;
				this.executeParams = this.executeParamsOld;
				this.resultCode = this.resultCodeOld;
				this.resultText = this.resultTextOld;
				this.note = this.noteOld;
            }

            return;

        }

        /// <summary>
        /// De-initializes the local values to their empty values.
        /// </summary>
        public override void DeinitializeValues()
        {

            base.DeinitializeValues();

            this.jobScheduleId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;  // Fkey
			this.jobScheduleName = ""; // Fkey alias to JobScheduleId
			this.executeDateTimeStart = DateTime.Now;
			this.executeDateTimeEnd = DateTime.Now;
			this.executeUserName = "";
			this.executeParams = "";
			this.resultCode = null;
			this.resultText = null;
			this.note = null;

            this.BackupValues();

            return;

        }
        #endregion


        #region EventHandlers
        #endregion


    }


}
