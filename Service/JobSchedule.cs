/******************************************************************************************************************************************************
 * Name: JobSchedule.cs
 * Author: Leonard Victoria
 * Create Date: 2017.07.17
 * Purpose: Provides service job schedule support.
 * History:
******************************************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;


namespace Triadcore.Service
{


    public class JobSchedulesQuickList : Triadcore.Base.QuickListBase
    {


        #region Properties
        /// <summary>
        /// Gets or sets the grouping logical statement for grouping filtering criteria.
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
        /// Gets the job schedule name compare logic for filtering.
        /// </summary>
        public Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic JobScheduleNameCompareLogic
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
        /// Gets or sets the job schedule name for filtering.
        /// </summary>
        public string JobScheduleName
        {
            get
            {
                return this.jobScheduleName;
            }
            set
            {
                this.jobScheduleName = value;
            }
        }
        /// <summary>
        /// Gets or sets the job schedule job Id for filtering.
        /// </summary>
        public int? JobId
        {
            get
            {
                return this.jobId;
            }
            set
            {
                this.jobId = value;
            }
        }
        /// <summary>
        /// Gets the job schedule name compare logic for filtering.
        /// </summary>
        public Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic NextStartCompareLogic
        {
            get
            {
                return this.nextStartCompareLogic;
            }
            set
            {
                this.nextStartCompareLogic = value;
            }
        }
        /// <summary>
        /// Gets or sets the default flag for filtering.
        /// </summary>
        public DateTime? NextStart
        {
            get
            {
                return this.nextStart;
            }
            set
            {
                this.nextStart = value;
            }
        }
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Base.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.JobSchedulesQuickListItem> BindableItemsList
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
        #endregion


        #region LocalItems
        private Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic groupingLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL;
        private int? jobId = null;
        private Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic jobScheduleNameCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
        private string jobScheduleName = null;
        private Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic nextStartCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
        private DateTime? nextStart = null;
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
                base.sqlCommand.CommandText = "Service.GetJobSchedules";

                #region Set Params
                if (this.groupingLogic == Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL)
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", this.groupingLogic.ToString());
                }
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
                if (this.jobScheduleNameCompareLogic == Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleNameCompareLogic", System.DBNull.Value);
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleNameCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(this.jobScheduleNameCompareLogic));
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", this.jobScheduleName);
                }
                if (this.nextStartCompareLogic == Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@NextStartCompareLogic", System.DBNull.Value);
                    base.sqlCommand.Parameters.AddWithValue("@NextStart", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@NextStartCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(this.nextStartCompareLogic));
                    base.sqlCommand.Parameters.AddWithValue("@NextStart", this.nextStart);
                }
                if (this.jobId == null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobId", this.jobId);
                }
                if (base.isActive == Triadcore.ClassLibrary.Utilities.TriStateBoolean.Undefined)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Active", base.isActive);
                }
                if (base.updateUserId == null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                }
                if (base.createUserId == null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@CreateUserId", base.createUserId);
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
                    item.JobScheduleName = sqlDr.GetString(1);
                    item.Description = sqlDr.GetString(2);
                    item.JobScheduleTypeName = sqlDr.GetString(4);
                    item.BaseDateTime = sqlDr.GetDateTime(5);
					if(!sqlDr.IsDBNull(6))
					{
						item.NextStart = sqlDr.GetDateTime(6);
					}
                    item.JobId = sqlDr.GetInt32(15);
                    item.JobName = sqlDr.GetString(16);
                    item.Active = Convert.ToBoolean(sqlDr.GetBoolean(17));
                    item.UpdateDate = sqlDr.GetDateTime(18);
                    item.UpdateUserId = sqlDr.GetInt32(19);
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                    lastUid = uid;
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in JobSchedulesQuickList.GetItems() at Uid=" + uid.ToString() + " (last Uid=" +  lastUid.ToString() + ") while retrieving Uid list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in JobSchedulesQuickListGetItems() at Uid=" + uid.ToString() + " (last Uid=" +  lastUid.ToString() + ") while retrieving Uid list. The exception is: " + ex.Message);
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
            this.jobId = null;
            this.jobScheduleNameCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
            this.jobScheduleName = null;
            this.nextStartCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
            this.nextStart = null;

            return;

        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.JobSchedulesQuickListItem newItem = new Triadcore.Service.JobSchedulesQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            newItem.JobScheduleName = Triadcore.ClassLibrary.Utilities.NullText;
            this.itemsQuickList.Insert(0, newItem);
            return;
        }
        #endregion


    }

    
    public class JobSchedulesQuickListItem : Triadcore.Base.QuickListItemBase
    {
        public int JobScheduleId
        {
            get
            {
                return base.itemUid;
            }
        }
        public string JobScheduleName { get; set; } = "";
        public string Description { get; set; } = "";
        public string JobScheduleTypeName { get; set; } = "";
        public DateTime BaseDateTime { get; set; } = DateTime.MaxValue;
        public DateTime NextStart { get; set; } = DateTime.MaxValue;
        public int JobId { get; set; } = -1;
        public string JobName { get; set; } = "";
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
        /// Gets or sets JobScheduleName.
        /// </summary>
        public string JobScheduleName
        {
            get
            {
                return this.jobScheduleName;
            }
            set
            {
                if (this.jobScheduleName != Triadcore.ClassLibrary.Utilities.CleanSpaces(value))
                {
                    this.jobScheduleName = Triadcore.ClassLibrary.Utilities.CleanSpaces(value);
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the scheduled job description.
        /// </summary>
        public string Description
        {
            get
            {
                return this.description;
            }
            set
            {

                if (this.description != value.Trim())
                {
                    this.description = value.Trim();
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the job schedule type Uid.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets the job schedule type name.
        /// </summary>
        public string JobScheduleTypeName
        {
            get
            {
                return this.jobScheduleTypeName;
            }
        }
        /// <summary>
        /// Gets or sets scheduled job JobId.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets the job schedule job name.
        /// </summary>
        public string JobName
        {
            get
            {
                return this.jobName;
            }
        }
        /// <summary>
        /// The user name to run the job as.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// The password to use for the RunAsUser.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets the date and time of the next scheduled job run time after the current scheduled job time.
        /// </summary>
        public DateTime NextStart
        {
            get
            {
                return this.nextStart;
            }
        }
        /// <summary>
        /// Gets or sets the date and time the schedule is to go into effect and from which date/time recurring schedules are to be based.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the interval number of the job schedule.
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
                    if (value > 0)
                    {
                        this.interval = value;
                    }
                    else
                    {
                        this.interval = null;
                    }
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the month number of the job schedule.
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
                    if (value >= 1)
                    {
                        this.month = value;
                    }
                    else
                    {
                        this.month = null;
                    }
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the weekday index of the job schedule.
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
                    if (value >= 1)
                    {
                        this.day = value;
                    }
                    else
                    {
                        this.day = null;
                    }
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the date number of the job schedule.
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
                    if (value >= 1)
                    {
                        this.date = value;
                    }
                    else
                    {
                        this.date = null;
                    }
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the time number of the job schedule.
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
                    if (value >= 0)
                    {
                        this.time = value;
                    }
                    else
                    {
                        this.time = null;
                    }
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets or sets the job schedule recurring flag.
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
                    if (!base.isNew)
                    {
                        base.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets the job schedule history.
        /// </summary>
        public Triadcore.Service.JobScheduleHistoriesQuickList History
        {
            get
            {
                return this.history;
            }
        }
        #endregion


        #region LocalItems
        // Working data items.
        private string jobScheduleName = string.Empty;
        private string description = string.Empty;
        private int jobScheduleTypeId = -1;
        private DateTime baseDateTime = DateTime.MaxValue;
        private int? interval = null;
        private int? month = null;
        private int? day = null;
        private int? date = null;
        private int? time = null;
        private bool isRecurring = true;
        private string runAsUser = string.Empty;
        private string runAsPassword = string.Empty;
        private int jobId = -1;
        // Backup/restore data items.
        private string jobScheduleNameOld = string.Empty;
        private string descriptionOld = string.Empty;
        private int jobScheduleTypeIdOld = -1;
        private DateTime baseDateTimeOld = DateTime.MaxValue;
        private int? intervalOld = null;
        private int? monthOld = null;
        private int? dayOld = null;
        private int? dateOld = null;
        private int? timeOld = null;
        private bool isRecurringOld = true;
        private string runAsUserOld = string.Empty;
        private string runAsPasswordOld = string.Empty;
        private int jobIdOld = -1;
        //
        private DateTime nextStart = DateTime.MaxValue;
        private string jobScheduleTypeName = string.Empty;
        private string jobName = string.Empty;
        private Triadcore.Service.JobScheduleHistoriesQuickList history = null;
        #endregion


        #region Constructors
        public JobSchedule(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public JobSchedule(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobScheduleId) : base(dbObject, user, jobScheduleId)
        {
        }
        #endregion


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
                base.sqlCommand.CommandText = "Service.GetJobSchedules";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleNameCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@NextStartCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@NextStart", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);

                // Execute the stored procedure
                sqlDr = base.sqlCommand.ExecuteReader();

                // Get data from resultset
                if (sqlDr.HasRows)
                {
                    sqlDr.Read();
                    base.itemUid = sqlDr.GetInt32(0);
                    this.jobScheduleName = sqlDr.GetString(1);
                    this.description = sqlDr.GetString(2);
                    this.jobScheduleTypeId = sqlDr.GetInt32(3);
                    this.jobScheduleTypeName = sqlDr.GetString(4);
                    this.baseDateTime = sqlDr.GetDateTime(5);
					if(!sqlDr.IsDBNull(6))
					{
						this.nextStart = sqlDr.GetDateTime(6);
					}
                    if (!sqlDr.IsDBNull(7))
                    {
                        this.interval = sqlDr.GetInt32(7);
                    }
                    if (!sqlDr.IsDBNull(8))
                    {
                        this.month = sqlDr.GetInt32(8);
                    }
                    if (!sqlDr.IsDBNull(9))
                    {
                        this.day = sqlDr.GetInt32(9);
                    }
                    if (!sqlDr.IsDBNull(10))
                    {
                        this.date = sqlDr.GetInt32(10);
                    }
                    if (!sqlDr.IsDBNull(11))
                    {
                        this.time = sqlDr.GetInt32(11);
                    }
                    this.isRecurring = sqlDr.GetBoolean(12);
                    this.runAsUser = sqlDr.GetString(13);
                    this.runAsPassword = sqlDr.GetString(14);
                    this.jobId = sqlDr.GetInt32(15);
                    this.jobName = sqlDr.GetString(16);
                    base.isActive = Convert.ToBoolean(sqlDr.GetBoolean(17));
                    base.updateDate = sqlDr.GetDateTime(18);
                    base.updateUserId = sqlDr.GetInt32(19);
                    base.createDate = sqlDr.GetDateTime(20);
                    base.createUserId = sqlDr.GetInt32(21);
                    base.recordComment = sqlDr.GetString(22);
                    base.isValid = true;
                }
                else
                {
                    base.isValid = false;
                }

                base.isDirty = false;

                // Backup data to local data items.
                this.BackupValues();

                if (this.isValid)
                {
                    base.ItemSuccessfullyRetrieved();
                }

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in JobSchedule.GetItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in JobSchedule.GetItem(). The exception is: " + ex.Message);

            }
            finally
            {

                if (sqlDr != null)
                {
                    sqlDr.Close();
                }
                base.database.CloseConnectionConditionally();

            }

            base.PostGetItem();

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

            if (this.jobScheduleName.Trim() == "")
            {
                isValid = false;
                base.errorMessages.Add("The job schedule name cannot be blank.");
            }

            if (this.jobId == -1)
            {
                isValid = false;
                base.errorMessages.Add("The job Id is invalid.");
            }

            if (this.baseDateTime == DateTime.MaxValue)
            {
                isValid = false;
                base.errorMessages.Add("The base date/time.");
            }

            if (this.jobScheduleTypeId == -1)
            {
                isValid = false;
                base.errorMessages.Add("The job schedule type Id is invalid.");
            }

            if (this.interval == null && this.date == null && this.month == null && this.day == null && this.time == null)
            {
                isValid = false;
                base.errorMessages.Add("There are no schedule components set.");
            }

            if (this.month != null && (this.month < 1 || this.month > 12 ))
            {
                isValid = false;
                base.errorMessages.Add("Invalid month number [" + this.month.ToString() + "].");
            }

            if (this.day != null && (this.day < 1 || this.day > 7 ))
            {
                isValid = false;
                base.errorMessages.Add("Invalid weekday index [" + this.day.ToString() + "].");
            }

            if (this.date != null && (this.date < 0 || this.date > 31))
            {
                isValid = false;
                base.errorMessages.Add("Invalid date number [" + this.date.ToString() + "].");
            }

            if (this.time != null && (this.time < 0 || this.time>2359))
            {
                isValid = false;
                base.errorMessages.Add("Invalid time number [" + this.time.ToString() + "].");
            }

            if (isValid && this.IsDuplicate())
            {
                isValid = false;
                base.errorMessages.Add("The organization type name \"" + this.jobScheduleName + "\" already exists.");
            }

            return isValid;

        }

        /// <summary>
        /// Updates the jobSchedule in the datastore.
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
                base.sqlCommand.CommandText = "Service.UpdateJobSchedule";

                // Set stored procedure parameters.
                if (!base.isNew)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleName", this.jobScheduleName);
                base.sqlCommand.Parameters.AddWithValue("@Description", this.description);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", this.jobScheduleTypeId);
                base.sqlCommand.Parameters.AddWithValue("@JobId", this.jobId);
                base.sqlCommand.Parameters.AddWithValue("@BaseDate", this.baseDateTime);
                if (this.interval != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Interval", this.interval);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Interval", System.DBNull.Value);
                }
                if (this.month != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Month", this.month);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Month", System.DBNull.Value);
                }
                if (this.day != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Day", this.day);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Day", System.DBNull.Value);
                }
                if (this.date != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Date", this.date);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Date", System.DBNull.Value);
                }
                if (this.time != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Time", this.time);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Time", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@IsRecurring", this.isRecurring);
                base.sqlCommand.Parameters.AddWithValue("@RunAsUser", this.runAsUser);
                base.sqlCommand.Parameters.AddWithValue("@RunAsPassword", this.runAsPassword);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);
                base.sqlCommand.Parameters.AddWithValue("@RecordComment", base.recordComment);

                // Execute stored procedure.
                int lastUpdatedId = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns jobSchedule ID of last updated/inserted jobSchedule.

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

                if (sqlEx.Number == 2627)
                {
                    base.errorMessages.Add("Cannot add item \"" + this.jobScheduleName + "\", item already exists.");
                }
                throw new Exception("A SQL exception occurred in JobSchedule.UpdateItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in JobSchedule.UpdateItem() when attempting to get an jobSchedule. The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in JobSchedule.UpdateItems() when attempting to use method GetItem() to refresh the data after an apparent successful update. The exception is: " + ex.Message);
            }

            base.PostUpdateItem();

            return;

        }

        /// <summary>
        /// Sets the Active indicator in the datastore.
        /// </summary>
        public override void DeleteItem()
        {

            base.DeleteItem();

            base.sqlCommand = new System.Data.SqlClient.SqlCommand();
            int returnCode = 0;

            if (base.isNew)
            {
                throw new Exception("Cannot delete a new jobSchedule.");
            }

            // Delete the JobSchedule.
            try
            {

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "Service.DeleteJobSchedule";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);

                // Execute stored procedure.
                returnCode = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns an error code. 0=no error.

                if (returnCode == 0)
                {
                    base.ItemSuccessfullyDeleted();
                }
                else
                {
                    throw new Exception("WARNING! The attempt to delete the jobSchedule returned a non-zero return code.  The return code is: " + returnCode.ToString() + ".");
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
                    throw new Exception("A SQL exception occurred in JobSchedule.DeleteItem().  The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in JobSchedule.DeleteItem(). The exception is: " + ex.Message);

            }
            finally
            {

                base.database.CloseConnectionConditionally();

            }

            // The jobSchedule could not be deleted because other data contains a reference to it.
            // Set the jobSchedule as INACTIVE.
            if (returnCode == 1)
            {
                try
                {
                    this.SetActiveIndicator(false);
                    base.clientMessages.Add("The JobSchedule could not be deleted in the database because other data contains a reference to it." +
                                            " The jobSchedule was instead set to an INACTIVE status in the database.");
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

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
                base.sqlCommand.CommandText = "Service.SetJobScheduleActivation";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@Active", indicator);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);

                // Execute stored procedure.
                int lastUpdatedId = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns jobSchedule ID of last updated jobSchedule.

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

                throw new Exception("A SQL exception occurred in JobSchedule.SetActiveIndicator(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in JobSchedule.SetActiveIndicator(). The exception is: " + ex.Message);

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
        /// Searches for an existing item that already has the same unique name.
        /// </summary>
        /// <returns>True if the name already exists, False otherwise.</returns>
        public override bool IsDuplicate()
        {
            base.IsDuplicate();
            bool dupeFound = false;
            return dupeFound;
        }

        /// <summary>
        /// Restores the jobSchedule data that has not been saved to the datastore to their original state.
        /// </summary>
        public override void UndoChanges()
        {

            if (base.isDirty)
            {
                this.jobScheduleName = this.jobScheduleNameOld;
                this.description = this.descriptionOld;
                this.baseDateTime = this.baseDateTimeOld;
                this.jobScheduleTypeId = this.jobScheduleTypeIdOld;
                this.interval = this.intervalOld;
                this.month = this.monthOld;
                this.day = this.dayOld;
                this.date = this.dateOld;
                this.time = this.timeOld;
                this.isRecurring = this.isRecurringOld;
                this.runAsUser = this.runAsUserOld;
                this.runAsPassword = this.runAsPasswordOld;
                this.jobId = this.jobIdOld;
                base.isDirty = false;
            }

            return;

        }

        /// <summary>
        /// Writes data to backup local data items for later retrieval of the original data values.
        /// </summary>
        public override void BackupValues()
        {

            this.jobScheduleNameOld = this.jobScheduleName;
            this.descriptionOld = this.description;
            this.baseDateTimeOld = this.baseDateTime;
            this.jobScheduleTypeIdOld = this.jobScheduleTypeId;
            this.intervalOld = this.interval;
            this.monthOld = this.month;
            this.dayOld = this.day;
            this.dateOld = this.date;
            this.timeOld = this.time;
            this.isRecurringOld = this.isRecurring;
            this.runAsUserOld = this.runAsUser;
            this.runAsPasswordOld = this.runAsPassword;
            this.jobIdOld = this.jobId;

            return;

        }

        /// <summary>
        /// De-initializes the local values to their empty states.
        /// </summary>
        public override void DeinitializeValues()
        {

            base.DeinitializeValues();

            this.jobScheduleName = string.Empty;
            this.description = string.Empty;
            this.nextStart = DateTime.MaxValue;
            this.baseDateTime = DateTime.MaxValue;
            this.jobScheduleTypeId = -1;
            this.interval = null;
            this.month = null;
            this.day = null;
            this.date = null;
            this.time = null;
            this.isRecurring = true;
            this.runAsUser = string.Empty;
            this.runAsPassword = string.Empty;
            this.jobId = -1;

            this.nextStart = DateTime.MaxValue;
            this.jobScheduleTypeName = string.Empty;
            this.jobName = String.Empty;

            this.BackupValues();
            
            return;

        }

        /// <summary>
        /// Sets the next run datetime for a job to run and returns the datetime schedule that was set.
        /// </summary>
        /// <returns>A System.DateTime{} object specifying the next scheduled datetime.</returns>
        public DateTime UpdateJobScheduleNextStart()
        {

            DateTime newNextStart = DateTime.MaxValue;

            base.sqlCommand = new System.Data.SqlClient.SqlCommand();
            System.Data.SqlClient.SqlDataReader sqlDr = null;

            try
            {

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "Service.UpdateJobScheduleNextStart";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updatingUser.UserId);

                // Execute stored procedure.
                //int lastUpdatedId = Convert.ToInt32(base.sqlCommand.ExecuteScalar()); // Returns jobSchedule ID of last updated jobSchedule.
                sqlDr = base.sqlCommand.ExecuteReader();

                // Get data from resultset
                if (sqlDr.HasRows)
                {
                    sqlDr.Read();
                    newNextStart = sqlDr.GetDateTime(0);
                }
                else
                {
                    throw new Exception("Call to update the next job schedule start date did not return a valid date.");
                }

            }
            catch (SqlException sqlEx)
            {

                throw new Exception("A SQL exception occurred in JobSchedule.UpdateJobScheduleNextStart(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in JobSchedule.UpdateJobScheduleNextStart(). The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.JobSchedule.UpdateJobScheduleNextStart() when attempting to use method GetItem() to refresh the data after an apparent successful update to set the item ACTIVE flag. The exception is: " + ex.Message);
            }

            return newNextStart;

        }

        /// <summary>
        /// Retrieve the job run history for the job schedule.
        /// </summary>
        /// <returns>A Triadcore.Service.JobScheduleHistoriesQuickList{} object.</returns>
        public Triadcore.Service.JobScheduleHistoriesQuickList GetJobScheduleHistory()
        {

            try
            {
                this.history = new JobScheduleHistoriesQuickList(base.database, base.updatingUser);
                this.history.JobScheduleId = base.itemUid;
                this.history.GetItems();
            }
            catch(Exception ex)
            {
                throw new Exception("Error attempting to retrieve job schedule history for job schedule Id [" + base.itemUid.ToString() + "]: " + ex.Message);
            }

            return this.history;

        }
        #endregion


    }


}
