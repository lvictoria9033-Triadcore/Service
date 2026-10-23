/******************************************************************************************************************************************************
* Name        : JobSchedule.cs
* Purpose     : Provides JobSchedule support.
* Create Date : 2026.10.23
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

	
	public class JobSchedulesQuickList : Triadcore.Base.QuickListBase
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
		/// JobScheduleName compare logic for filtering.
		/// </summary>
		public string JobScheduleNameCompareLogic
		{
			get
			{
				return this.jobScheduleNameCompareLogic;
			}
			set
			{
				this.jobScheduleNameCompareLogic = value;
			}
		}
		/// <summary>
		/// The unique job schedule name.
		/// </summary>
		public string JobScheduleName
		{
			get
			{
				return this.jobScheduleName;
			}
			set
			{
				if (this.jobScheduleName != value)
				{
					this.jobScheduleName = value;
				}
			}
		}
		/// <summary>
		/// The UID of the job for which the job schedule is created.
		/// Fkey
		/// </summary>
		public int? JobId
		{
			get
			{
				return this.jobId;
			}
			set
			{
				if (this.jobId != value)
				{
					this.jobId = value;
				}
			}
		}
		/// <summary>
		/// The UID of the job schedule type.
		/// Fkey
		/// </summary>
		public int? JobScheduleTypeId
		{
			get
			{
				return this.jobScheduleTypeId;
			}
			set
			{
				if (this.jobScheduleTypeId != value)
				{
					this.jobScheduleTypeId = value;
				}
			}
		}
		/// <summary>
		/// The next time the job is scheduled to run (read-only).
		/// </summary>
		public DateTime? NextStart
		{
			get
			{
				return this.nextStart;
			}
			set
			{
				if (this.nextStart != value)
				{
					this.nextStart = value;
				}
			}
		}
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Base.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.JobSchedulesQuickListItem> BindableJobSchedulesList
        {
            get
            {
                List<Triadcore.Service.JobSchedulesQuickListItem> listOut = new List<Triadcore.Service.JobSchedulesQuickListItem>();
                foreach (Triadcore.Service.JobSchedulesQuickListItem c in base.itemsQuickList)
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
        private string jobScheduleNameCompareLogic = null; 
		private string jobScheduleName = null;
		private int? jobId = null;  // Fkey
		private int? jobScheduleTypeId = null;  // Fkey
		private DateTime? nextStart = null;
        //
        protected string acbBuildDate = "2026.10.23";
        #endregion


        #region Constructors
        public JobSchedulesQuickList(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
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
                base.sqlCommand.CommandText = "[Service].[GetJobSchedules]";
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
			    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
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
				if (this.jobScheduleNameCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@jobScheduleNameCompareLogic", this.jobScheduleNameCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@jobScheduleNameCompareLogic", System.DBNull.Value);
				}
				if (this.jobScheduleName != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", this.jobScheduleName);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", System.DBNull.Value);
				}
				// Fkey
				if (this.jobId != null && this.jobId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", this.jobId); // Fkey
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value); // Fkey
				}
				// Fkey
				if (this.jobScheduleTypeId != null && this.jobScheduleTypeId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", this.jobScheduleTypeId); // Fkey
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value); // Fkey
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
                    Triadcore.Service.JobSchedulesQuickListItem item = new Triadcore.Service.JobSchedulesQuickListItem(uid);
                    item.CreateDate = sqlDr.GetDateTime(1);
					item.CreateUserId = sqlDr.GetInt32(2); // Fkey
					item.CreateUserName = sqlDr.GetString(3);  // Fkey alias to CreateUserId
					item.UpdateDate = sqlDr.GetDateTime(4);
					item.UpdateUserId = sqlDr.GetInt32(5); // Fkey
					item.UpdateUserName = sqlDr.GetString(6);  // Fkey alias to UpdateUserId
					item.Active = sqlDr.GetBoolean(7);
					item.JobScheduleName = sqlDr.GetString(8);
					item.JobId = sqlDr.GetInt32(10); // Fkey
					item.JobName = sqlDr.GetString(11);  // Fkey alias to JobId
					item.JobScheduleTypeId = sqlDr.GetInt32(12); // Fkey
					item.JobScheduleTypeName = sqlDr.GetString(13);  // Fkey alias to JobScheduleTypeId
					if (!sqlDr.IsDBNull(15))
					{
						item.NextStart = sqlDr.GetDateTime(15);
					}
					else
					{
						item.NextStart = null;
					}
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                    lastUid = uid;
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedulesQuickList.GetItems() while retrieving data list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobSchedulesQuickList.GetItems() while retrieving data list. The exception is: " + ex.Message);
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
            this.jobScheduleNameCompareLogic = null;
			this.jobScheduleName = null;
			this.jobId = null;  // Fkey
			this.jobScheduleTypeId = null;  // Fkey

            return;

        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.JobSchedulesQuickListItem newItem = new Triadcore.Service.JobSchedulesQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            this.itemsQuickList.Insert(0, newItem);
        }
        #endregion


    }


	public class JobSchedulesQuickListItem : Triadcore.Base.QuickListItemBase
    {

        /// <summary>
	    /// The JobSchedule unique identifier.
	    /// </summary>    
        public int JobScheduleId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// The unique job schedule name.
		/// </summary>
		public string JobScheduleName
		{
			get;
			set;
		}
		/// <summary>
		/// The UID of the job for which the job schedule is created.
		/// </summary>
		public int? JobId
		{
			get;
			set;
		}
		/// <summary>
		/// JobId name.
		/// </summary>
		public string JobName
		{
			get;
			set;
		}
		/// <summary>
		/// The UID of the job schedule type.
		/// </summary>
		public int? JobScheduleTypeId
		{
			get;
			set;
		}
		/// <summary>
		/// JobScheduleTypeId name.
		/// </summary>
		public string JobScheduleTypeName
		{
			get;
			set;
		}
		/// <summary>
		/// The next time the job is scheduled to run (read-only).
		/// </summary>
		public DateTime? NextStart
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
                return "2026.10.23";
            }
        }

        public JobSchedulesQuickListItem(int itemUid) : base(itemUid)
        {
        }

    }



	public class JobSchedule : Triadcore.Base.ItemBase
    {


        #region Properties
        /// <summary>
        /// Gets the item unique ID in the datastore.
        /// </summary>
        public int JobScheduleId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// The unique job schedule name..
		/// </summary>
		public string JobScheduleName
		{
			get
			{
				return this.jobScheduleName;
			}
			set
			{
				if (this.jobScheduleName != value)
				{
					this.jobScheduleName = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// Free-text description of the job schedule..
		/// </summary>
		public string Description
		{
			get
			{
				return this.description;
			}
			set
			{
				if (this.description != value)
				{
					this.description = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The UID of the job for which the job schedule is created..
		/// Fkey to Service.Jobs.
		/// </summary>
		public int JobId
		{
			get
			{
				return this.jobId;
			}
			set
			{
				if (this.jobId != value)
				{
					this.jobId = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The foreign key alias of foreign key JobId.
		/// </summary>
		public string JobName
		{
			get
			{
				return (this.jobName == null ? "" : this.jobName);
			}
		}
		/// <summary>
		/// The UID of the job schedule type..
		/// Fkey to Service.JobScheduleTypes.
		/// </summary>
		public int JobScheduleTypeId
		{
			get
			{
				return this.jobScheduleTypeId;
			}
			set
			{
				if (this.jobScheduleTypeId != value)
				{
					this.jobScheduleTypeId = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The foreign key alias of foreign key JobScheduleTypeId.
		/// </summary>
		public string JobScheduleTypeName
		{
			get
			{
				return (this.jobScheduleTypeName == null ? "" : this.jobScheduleTypeName);
			}
		}
		/// <summary>
		/// The base date time from which the schedule next start is calculated..
		/// </summary>
		public DateTime BaseDateTime
		{
			get
			{
				return this.baseDateTime;
			}
			set
			{
				if (this.baseDateTime != value)
				{
					this.baseDateTime = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The next time the job is scheduled to run (read-only)..
		/// </summary>
		public DateTime? NextStart
		{
			get
			{
				return this.nextStart;
			}
			set
			{
				if (this.nextStart != value)
				{
					this.nextStart = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// If the job execution is to occur after the elapse of a specified number of minutes, specifies the elapsed minutes until the job runs..
		/// </summary>
		public int? Interval
		{
			get
			{
				return this.interval;
			}
			set
			{
				if (this.interval != value)
				{
					this.interval = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// If the job execution is to occurr at a certain date of the month, specifies the date the job is to run..
		/// </summary>
		public int? Date
		{
			get
			{
				return this.date;
			}
			set
			{
				if (this.date != value)
				{
					this.date = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// If the job execution is to occur in a certain month, specifies the month the job is to run (combined with date and/or day and time)..
		/// </summary>
		public int? Month
		{
			get
			{
				return this.month;
			}
			set
			{
				if (this.month != value)
				{
					this.month = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// If the job execution is to occur on a certain day of the week, specifies the zero-based index of the day of week the job is to run (Sunday=0)..
		/// </summary>
		public int? Day
		{
			get
			{
				return this.day;
			}
			set
			{
				if (this.day != value)
				{
					this.day = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// If the job execution is to occur at a certain time of day. specifies the time the job is to run. Expessed in 24-hr format in integer form..
		/// </summary>
		public int? Time
		{
			get
			{
				return this.time;
			}
			set
			{
				if (this.time != value)
				{
					this.time = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// Specifies if the schedule is a recurring/repeating schedule..
		/// </summary>
		public bool IsRecurring
		{
			get
			{
				return this.isRecurring;
			}
			set
			{
				if (this.isRecurring != value)
				{
					this.isRecurring = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The user account login the job should run as..
		/// </summary>
		public string RunAsUser
		{
			get
			{
				return this.runAsUser;
			}
			set
			{
				if (this.runAsUser != value)
				{
					this.runAsUser = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The user account password the job shoud run as..
		/// </summary>
		public string RunAsPassword
		{
			get
			{
				return this.runAsPassword;
			}
			set
			{
				if (this.runAsPassword != value)
				{
					this.runAsPassword = value;
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
        private string jobScheduleName = "";
		private string description = "";
		private int jobId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private string jobName = null; // Fkey alias to JobId
		private int jobScheduleTypeId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private string jobScheduleTypeName = null; // Fkey alias to JobScheduleTypeId
		private DateTime baseDateTime = DateTime.Now;
		private DateTime? nextStart = null;
		private int? interval = null;
		private int? date = null;
		private int? month = null;
		private int? day = null;
		private int? time = null;
		private bool isRecurring = false;
		private string runAsUser = "";
		private string runAsPassword = "";
		//
		private string jobScheduleNameOld = "";
		private string descriptionOld = "";
		private int jobIdOld = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private int jobScheduleTypeIdOld = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger; // Fkey
		private DateTime baseDateTimeOld = DateTime.Now;
		private DateTime? nextStartOld = null;
		private int? intervalOld = null;
		private int? dateOld = null;
		private int? monthOld = null;
		private int? dayOld = null;
		private int? timeOld = null;
		private bool isRecurringOld = false;
		private string runAsUserOld = "";
		private string runAsPasswordOld = "";
        //
        protected string acbBuildDate = "2026.10.23";
        #endregion


        #region Constructors
        public JobSchedule(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public JobSchedule(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobScheduleId) : base(dbObject, user, jobScheduleId)
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
                base.sqlCommand.CommandText = "[Service].[GetJobSchedules]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleNameCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value); // FKey
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
					this.jobScheduleName = sqlDr.GetString(8);
					this.description = sqlDr.GetString(9);
					this.jobId = sqlDr.GetInt32(10); // Fkey
					this.jobName = sqlDr.GetString(11);  // Fkey alias to JobId
					this.jobScheduleTypeId = sqlDr.GetInt32(12); // Fkey
					this.jobScheduleTypeName = sqlDr.GetString(13);  // Fkey alias to JobScheduleTypeId
					this.baseDateTime = sqlDr.GetDateTime(14);
					if (!sqlDr.IsDBNull(15))
					{
						this.nextStart = sqlDr.GetDateTime(15);
					}
					else
					{
						this.nextStart = null;
					}
					if (!sqlDr.IsDBNull(16))
					{
						this.interval = sqlDr.GetInt32(16);
					}
					else
					{
						this.interval = null;
					}
					if (!sqlDr.IsDBNull(17))
					{
						this.date = sqlDr.GetInt32(17);
					}
					else
					{
						this.date = null;
					}
					if (!sqlDr.IsDBNull(18))
					{
						this.month = sqlDr.GetInt32(18);
					}
					else
					{
						this.month = null;
					}
					if (!sqlDr.IsDBNull(19))
					{
						this.day = sqlDr.GetInt32(19);
					}
					else
					{
						this.day = null;
					}
					if (!sqlDr.IsDBNull(20))
					{
						this.time = sqlDr.GetInt32(20);
					}
					else
					{
						this.time = null;
					}
					this.isRecurring = sqlDr.GetBoolean(21);
					this.runAsUser = sqlDr.GetString(22);
					this.runAsPassword = sqlDr.GetString(23);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedule.GetItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.GetItem(). The exception is: " + ex.Message);

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
                base.sqlCommand.CommandText = "[Service].[UpdateJobSchedule]";
			
                #region Set stored procedure parameters
                if (!base.isNew)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", this.jobScheduleName);
				base.sqlCommand.Parameters.AddWithValue("@Description", this.description);
				// Foreign key
				if (this.jobId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", this.jobId);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
				}
				// Foreign key
				if (this.jobScheduleTypeId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", this.jobScheduleTypeId);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value);
				}
				base.sqlCommand.Parameters.AddWithValue("@BaseDateTime", this.baseDateTime);
				if (this.nextStart == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@NextStart", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@NextStart", this.nextStart);
				}
				if (this.interval == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Interval", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Interval", this.interval);
				}
				if (this.date == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Date", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Date", this.date);
				}
				if (this.month == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Month", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Month", this.month);
				}
				if (this.day == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Day", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Day", this.day);
				}
				if (this.time == null)
				{
					base.sqlCommand.Parameters.AddWithValue("@Time", System.DBNull.Value);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@Time", this.time);
				}
				base.sqlCommand.Parameters.AddWithValue("@IsRecurring", this.isRecurring);
				base.sqlCommand.Parameters.AddWithValue("@RunAsUser", this.runAsUser);
				base.sqlCommand.Parameters.AddWithValue("@RunAsPassword", this.runAsPassword);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedule.UpdateItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.UpdateItem() when attempting to retrieve data. The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.UpdateItem() when attempting to use method GetItem() to refresh the data after an apparent successful update. The exception is: " + ex.Message);
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
                base.sqlCommand.CommandText = "[Service].[SetJobScheduleActivation]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedule.SetActiveIndicator(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.SetActiveIndicator(). The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.SetActiveIndicator(bool) when attempting to use method GetItem() to refresh the data after an apparent successful update to set the item ACTIVE flag. The exception is: " + ex.Message);
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
            string deleteNote = "JobScheduleName=" + this.jobScheduleName.ToString() + " |  JobId=" + this.jobId.ToString() + " |  Interval =" + (this.interval != null ? this.interval.ToString() : "") + " |  Date =" + (this.date != null ? this.date.ToString() : "") + " |  Day =" + (this.day != null ? this.day.ToString() : "") + " |  IsRecurring=" + this.isRecurring.ToString() + ".";

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
                base.sqlCommand.CommandText = "[Service].[DeleteJobSchedule]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
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
                    throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedule.DeleteItem().  The error code is: " + sqlEx.Number.ToString() + ". The execption is: " + sqlEx.Message);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.DeleteItem(). The exception is: " + ex.Message);

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

            // JobScheduleName - empty string not allowed
			if (this.jobScheduleName == null || this.jobScheduleName.Trim() == "")
			{
				isValid = false;
				base.errorMessages.Add("Field [JobScheduleName] cannot be null or blank.");
			}
			
			// JobId - Fkey
			if ((this.jobId == Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)) // Fkey
			{
				isValid = false;
				base.errorMessages.Add("Field [JobId] must be specified.");
			}
			
			// JobScheduleTypeId - Fkey
			if ((this.jobScheduleTypeId == Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)) // Fkey
			{
				isValid = false;
				base.errorMessages.Add("Field [JobScheduleTypeId] must be specified.");
			}
			
			// BaseDateTime
			if (this.baseDateTime == null)
			{
				this.baseDateTime = DateTime.Now; // set default to current datetime
			}
			
			// IsRecurring
			if (this.isRecurring == null)
			{
				this.isRecurring = false; // set default ="0"
			}
			
			if (isValid && this.IsDuplicate())
			{
				isValid = false;
				base.errorMessages.Add("The item with unique fields combination [JobScheduleName, JobId, IsRecurring] already exists in the datastore.");
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
                base.sqlCommand.CommandText = "[Service].[GetJobSchedules]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
			    base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value); 
				// Unique field
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleNameCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.EqualTo.ToString());
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", this.jobScheduleName); 
				// Unique combo field
				// Fkey
				if (this.jobId != Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", this.jobId);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
				}
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value);

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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobSchedule.IsDuplicate(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.IsDuplicate(). The exception is: " + ex.Message);

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

            this.jobScheduleNameOld = this.jobScheduleName;
			this.descriptionOld = this.description;
			this.jobIdOld = this.jobId; // Fkey
			this.jobScheduleTypeIdOld = this.jobScheduleTypeId; // Fkey
			this.baseDateTimeOld = this.baseDateTime;
			this.nextStartOld = this.nextStart;
			this.intervalOld = this.interval;
			this.dateOld = this.date;
			this.monthOld = this.month;
			this.dayOld = this.day;
			this.timeOld = this.time;
			this.isRecurringOld = this.isRecurring;
			this.runAsUserOld = this.runAsUser;
			this.runAsPasswordOld = this.runAsPassword;

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
                this.jobScheduleName = this.jobScheduleNameOld;
				this.description = this.descriptionOld;
				this.jobId = this.jobIdOld; // Fkey
				this.jobScheduleTypeId = this.jobScheduleTypeIdOld; // Fkey
				this.baseDateTime = this.baseDateTimeOld;
				this.nextStart = this.nextStartOld;
				this.interval = this.intervalOld;
				this.date = this.dateOld;
				this.month = this.monthOld;
				this.day = this.dayOld;
				this.time = this.timeOld;
				this.isRecurring = this.isRecurringOld;
				this.runAsUser = this.runAsUserOld;
				this.runAsPassword = this.runAsPasswordOld;
            }

            return;

        }

        /// <summary>
        /// De-initializes the local values to their empty values.
        /// </summary>
        public override void DeinitializeValues()
        {

            base.DeinitializeValues();

            this.jobScheduleName = "";
			this.description = "";
			this.jobId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;  // Fkey
			this.jobName = ""; // Fkey alias to JobId
			this.jobScheduleTypeId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;  // Fkey
			this.jobScheduleTypeName = ""; // Fkey alias to JobScheduleTypeId
			this.baseDateTime = DateTime.Now;
			this.nextStart = null;
			this.interval = null;
			this.date = null;
			this.month = null;
			this.day = null;
			this.time = null;
			this.isRecurring = false;
			this.runAsUser = "";
			this.runAsPassword = "";

            this.BackupValues();

            return;

        }
        #endregion


        #region EventHandlers
        #endregion


    }


}
