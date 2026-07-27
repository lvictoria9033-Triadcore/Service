/******************************************************************************************************************************************************
* Name        : Job.cs
* Purpose     : Provides Job support.
* Create Date : 2023.08.28
* Created By  : Triadcore (ACB)
******************************************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Triadcore;
using Triadcore.Base;


namespace Triadcore.Service
{


    public class JobsQuickList : Triadcore.Base.QuickListBase
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
        /// Gets or sets the compare logic to filter the The unique name for the job..
        /// </summary>
        public Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic JobNameCompareLogic
        {
            get
            {
                return this.jobNameCompareLogic;
            }
            set
            {
                this.jobNameCompareLogic = value;
            }
        }
        /// <summary>
        /// Gets or sets the JobName value for filtering.
        /// </summary>
        public string JobName
        {
            get
            {
                return this.jobName;
            }
            set
            {
                this.jobName = value;
            }
        }
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Base.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.JobsQuickListItem> BindableJobsList
        {
            get
            {
                List<Triadcore.Service.JobsQuickListItem> listOut = new List<Triadcore.Service.JobsQuickListItem>();
                foreach (Triadcore.Service.JobsQuickListItem c in base.itemsQuickList)
                {
                    listOut.Add(c);
                }
                return listOut;
            }
        }
        #endregion


        #region LocalItems
        private Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic groupingLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL;
        private Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic jobNameCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
        private string jobName = null;
        private Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic logFinishesCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
        private bool? logFinishes = null;
        #endregion


        #region Constructors
        public JobsQuickList(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
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
                base.sqlCommand.CommandText = "[Service].[GetJobs]";

                #region Set stored procedure parameters
                if (this.groupingLogic == Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL)
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", this.groupingLogic.ToString());
                }

                base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
                if (base.createUserId != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@CreateUserId", base.createUserId);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                }
                if (base.updateUserId != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                }
                if (base.active != Triadcore.ClassLibrary.Utilities.TriStateBoolean.Undefined)
                {
                    base.sqlCommand.Parameters.AddWithValue("@Active", base.active);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
                }
                if (this.jobNameCompareLogic != Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobNameCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(this.jobNameCompareLogic));
                    base.sqlCommand.Parameters.AddWithValue("@JobName", this.jobName);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobNameCompareLogic", System.DBNull.Value);
                    base.sqlCommand.Parameters.AddWithValue("@JobName", System.DBNull.Value);
                }
                if (this.logFinishesCompareLogic != Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@LogFinishesCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(this.logFinishesCompareLogic));
                    base.sqlCommand.Parameters.AddWithValue("@LogFinishes", this.logFinishes);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@LogFinishesCompareLogic", System.DBNull.Value);
                    base.sqlCommand.Parameters.AddWithValue("@LogFinishes", System.DBNull.Value);
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
                    Triadcore.Service.JobsQuickListItem item = new Triadcore.Service.JobsQuickListItem(uid);
                    item.CreateDate = sqlDr.GetDateTime(1);
                    item.CreateUserId = sqlDr.GetInt32(2);
                    item.CreateUserName = sqlDr.GetString(3);
                    item.UpdateDate = sqlDr.GetDateTime(4);
                    item.UpdateUserId = sqlDr.GetInt32(5);
                    item.UpdateUserName = sqlDr.GetString(6);
                    item.Active = sqlDr.GetBoolean(8);
                    item.JobName = sqlDr.GetString(10);
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                    lastUid = uid;
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in Triadcore.Service.Job.GetItems() while retrieving id list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.Job.GetItems() while retrieving id list. The exception is: " + ex.Message);
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
            this.jobNameCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
            this.jobName = null;
            this.logFinishesCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
            this.logFinishes = false;

            return;

        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.JobsQuickListItem newItem = new Triadcore.Service.JobsQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            this.itemsQuickList.Insert(0, newItem);
        }
        #endregion


    }


    public class JobsQuickListItem : Triadcore.Base.QuickListItemBase
    {

        public int JobId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
        /// The unique name for the job.
        /// </summary>
        public string JobName
        {
            get;
            set;
        }

        public JobsQuickListItem(int itemUid) : base(itemUid)
        {
        }

    }


    public class Job : Triadcore.Base.ItemBase
    {


        #region Properties
        /// <summary>
        /// Gets the item unique ID in the datastore.
        /// </summary>
        public int JobId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
        /// The field used for sorting.
        /// </summary>
        public string SortText
        {
            get
            {
                return this.sortText;
            }
            set
            {
                if (this.sortText != value)
                {
                    this.sortText = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// The unique name for the job.
        /// </summary>
        public string JobName
        {
            get
            {
                return this.jobName;
            }
            set
            {
                if (this.jobName != value)
                {
                    this.jobName = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Free-text job display name.
        /// </summary>
        public string JobFriendlyName
        {
            get
            {
                return this.jobFriendlyName;
            }
            set
            {
                if (this.jobFriendlyName != value)
                {
                    this.jobFriendlyName = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Free-text description of the job.
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
        /// Gets the base path used for job executables.
        /// </summary>
        public string BasePath
        {
            get
            {
                return this.basePath;
            }
        }
        /// <summary>
        /// The directory path to the job executable code.
        /// </summary>
        public string ExecPath
        {
            get
            {
                return this.execPath;
            }
            set
            {
                if (this.execPath != value)
                {
                    this.execPath = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// The file name of the executable code/file.
        /// </summary>
        public string ExecFile
        {
            get
            {
                return this.execFile;
            }
            set
            {
                if (this.execFile != value)
                {
                    this.execFile = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Gets the full path, including file name, of the executable.
        /// </summary>
        public string FullPath
        {
            get
            {
                if (this.execPath.IndexOf("{BasePath}") >= 0)
                {
                    return this.execPath.TrimStart('\\').Replace("{BasePath}", this.basePath.TrimEnd('\\')).TrimEnd('\\') + "\\" + this.execFile;
                }
                else
                {
                    return this.execPath.TrimEnd('\\') + "\\" + this.execFile;
                }

            }
        }
        /// <summary>
        /// The parameter string to pass to the executable.
        /// </summary>
        public string ParamString
        {
            get
            {
                return this.paramString;
            }
            set
            {
                if (this.paramString != value)
                {
                    this.paramString = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// Indicates if a log entry is to be made when the job starts.
        /// </summary>
        public bool LogStarts
        {
            get
            {
                return this.logStarts;
            }
            set
            {
                if (this.logStarts != value)
                {
                    this.logStarts = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// ndicates if a log entry is to be made when the job finishes.
        /// </summary>
        public bool LogFinishes
        {
            get
            {
                return this.logFinishes;
            }
            set
            {
                if (this.logFinishes != value)
                {
                    this.logFinishes = value;
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        #endregion


        #region Local Items
        private string sortText = "";
        private string jobName = "";
        private string jobFriendlyName = "";
        private string description = "";
        private string execPath = "";
        private string execFile = "";
        private string paramString = "";
        private bool logStarts = false;
        private bool logFinishes = false;
        //
        private string sortTextOld = "";
        private string jobNameOld = "";
        private string jobFriendlyNameOld = "";
        private string descriptionOld = "";
        private string execPathOld = "";
        private string execFileOld = "";
        private string paramStringOld = "";
        private bool logStartsOld = false;
        private bool logFinishesOld = false;
        //
        private string basePath = "";
        #endregion


        #region Constructors
        public Job(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public Job(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobId) : base(dbObject, user, jobId)
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
                base.sqlCommand.CommandText = "[Service].[GetJobs]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobNameCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobName", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@LogFinishesCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@LogFinishes", System.DBNull.Value);
                #endregion

                // Execute the stored procedure
                sqlDr = base.sqlCommand.ExecuteReader();

                // Get data from resultset
                if (sqlDr.HasRows)
                {
                    sqlDr.Read();
                    base.itemUid = sqlDr.GetInt32(0);
                    base.createDate = sqlDr.GetDateTime(1);
                    base.createUserId = sqlDr.GetInt32(2);
                    base.createUserName = sqlDr.GetString(3);
                    base.updateDate = sqlDr.GetDateTime(4);
                    base.updateUserId = sqlDr.GetInt32(5);
                    base.updateUserName = sqlDr.GetString(6);
                    base.recordComment = sqlDr.GetString(7);
                    base.active = sqlDr.GetBoolean(8);
                    this.sortText = sqlDr.GetString(9);
                    this.jobName = sqlDr.GetString(10);
                    this.jobFriendlyName = sqlDr.GetString(11);
                    this.description = sqlDr.GetString(12);
                    this.basePath = sqlDr.GetString(13);
                    this.execPath = sqlDr.GetString(14);
                    this.execFile = sqlDr.GetString(15);
                    this.paramString = sqlDr.GetString(16);
                    this.logStarts = sqlDr.GetBoolean(17);
                    this.logFinishes = sqlDr.GetBoolean(18);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.Job.GetItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.Job.GetItem(). The exception is: " + ex.Message);

            }
            finally
            {

                if (sqlDr != null && !sqlDr.IsClosed)
                {
                    sqlDr.Close();
                }
                base.database.CloseConnectionConditionally();

            }

            if (base.isValid)
            {
                //
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

            if (this.sortText == null)
            {
                isValid = false;
                base.errorMessages.Add("The SortText cannot be null.");
            }
            if (this.jobName == null)
            {
                isValid = false;
                base.errorMessages.Add("The JobName cannot be null.");
            }
            if (this.jobFriendlyName == null)
            {
                isValid = false;
                base.errorMessages.Add("The JobFriendlyName cannot be null.");
            }
            if (this.description == null)
            {
                isValid = false;
                base.errorMessages.Add("The Description cannot be null.");
            }
            if (this.execPath == null)
            {
                isValid = false;
                base.errorMessages.Add("The ExecPath cannot be null.");
            }
            if (this.execFile == null)
            {
                isValid = false;
                base.errorMessages.Add("The ExecFile cannot be null.");
            }
            if (this.paramString == null)
            {
                isValid = false;
                base.errorMessages.Add("The ParamString cannot be null.");
            }
            if (isValid && this.IsDuplicate())
            {
                isValid = false;
                base.errorMessages.Add("The item [JobName] already exists in the datastore.");
            }

            return isValid;

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
                msg.Append("Validation Error: ");
                if (this.errorMessages.Count > 0)
                {
                    foreach (string s in this.errorMessages)
                    {
                        msg.Append(" " + s);
                    }
                }
                else
                {
                    msg.Append(" Data item failed to validate.");
                }
                throw new Exception(msg.ToString());
            }

            try
            {

                base.sqlCommand = new System.Data.SqlClient.SqlCommand();

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[UpdateJob]";

                #region Set stored procedure parameters
                if (!base.isNew)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobId", base.itemUid);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                base.sqlCommand.Parameters.AddWithValue("@SortText", this.sortText);
                base.sqlCommand.Parameters.AddWithValue("@JobName", this.jobName);
                base.sqlCommand.Parameters.AddWithValue("@JobFriendlyName", this.jobFriendlyName);
                base.sqlCommand.Parameters.AddWithValue("@Description", this.description);
                base.sqlCommand.Parameters.AddWithValue("@ExecPath", this.execPath);
                base.sqlCommand.Parameters.AddWithValue("@ExecFile", this.execFile);
                base.sqlCommand.Parameters.AddWithValue("@ParamString", this.paramString);
                base.sqlCommand.Parameters.AddWithValue("@LogStarts", this.logStarts);
                base.sqlCommand.Parameters.AddWithValue("@LogFinishes", this.logFinishes);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.Job.UpdateItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.Job.UpdateItem() when attempting to retrieve data. The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.Job.UpdateItem() when attempting to use method GetItem() to refresh the data after an apparent successful update. The exception is: " + ex.Message);
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
                throw new Exception("Cannot delete a new data item.");
            }

            // Delete the data item.
            try
            {

                base.database.OpenConnection();

                base.sqlCommand.Connection = base.database.SQLConnection;
                base.sqlCommand.CommandType = CommandType.StoredProcedure;
                base.sqlCommand.CommandText = "[Service].[DeleteJob]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobId", base.itemUid);
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
                    throw new Exception("A SQL exception occurred in Triadcore.Service.Job.DeleteItem().  The error code is: " + sqlEx.Number.ToString() + ". The execption is: " + sqlEx.Message);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.Job.DeleteItem(). The exception is: " + ex.Message);

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
                base.sqlCommand.CommandText = "[Service].[SetJobActivation]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobId", base.itemUid);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.Job.SetActiveIndicator(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.Job.SetActiveIndicator(). The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.Job.SetActiveIndicator(bool) when attempting to use method GetItem() to refresh the data after an apparent successful update to set the item ACTIVE flag. The exception is: " + ex.Message);
            }

            base.PostSetActiveIndicator(active);

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
                this.sortText = this.sortTextOld;
                this.jobName = this.jobNameOld;
                this.jobFriendlyName = this.jobFriendlyNameOld;
                this.description = this.descriptionOld;
                this.execPath = this.execPathOld;
                this.execFile = this.execFileOld;
                this.paramString = this.paramStringOld;
                this.logStarts = this.logStartsOld;
                this.logFinishes = this.logFinishesOld;
            }

            return;

        }

        /// <summary>
        /// Writes data to backup local data items for later retrieval of the original data values.
        /// </summary>
        public override void BackupValues()
        {

            base.BackupValues();

            this.sortTextOld = this.sortText;
            this.jobNameOld = this.jobName;
            this.jobFriendlyNameOld = this.jobFriendlyName;
            this.descriptionOld = this.description;
            this.execPathOld = this.execPath;
            this.execFileOld = this.execFile;
            this.paramStringOld = this.paramString;
            this.logStartsOld = this.logStarts;
            this.logFinishesOld = this.logFinishes;

            return;

        }

        /// <summary>
        /// De-initializes the local values to their empty values.
        /// </summary>
        public override void DeinitializeValues()
        {

            base.DeinitializeValues();

            this.sortText = "";
            this.jobName = "";
            this.jobFriendlyName = "";
            this.description = "";
            this.basePath = "";
            this.execPath = "";
            this.execFile = "";
            this.paramString = "";
            this.logStarts = false;
            this.logFinishes = false;

            this.BackupValues();

            return;

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
                base.sqlCommand.CommandText = "[Service].[GetJobs]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobNameCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.EqualTo));
                base.sqlCommand.Parameters.AddWithValue("@JobName", this.jobName);
                base.sqlCommand.Parameters.AddWithValue("@LogFinishesCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@LogFinishes", System.DBNull.Value);

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

                throw new Exception("A SQL exception occurred in Triadcore.Service.Job.IsDuplicate(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.Job.IsDuplicate(). The exception is: " + ex.Message);

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
        #endregion


        #region EventHandlers
        #endregion


    }


}
