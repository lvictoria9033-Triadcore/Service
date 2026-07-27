/******************************************************************************************************************************************************
* Name        : JobScheduleHistory.cs
* Purpose     : Provides JobScheduleHistory support.
* Create Date : 2023.08.31
* Created By  : Triadcore (ACB)
* Special Note: This was originally built with ACB but has been manually modified to handle a situaiton that ACB does not handle -- inclusion of
*               foreign column [Service].[JobSchedules].[NextStart] because the foreign key column [jbschdls].[JobScheduleName] is already utilized.
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
        /// Gets or sets the JobScheduleId value for filtering.
        /// </summary>
        public int? JobScheduleId
        {
            get
            {
                return this.jobScheduleId;
            }
            set
            {
                this.jobScheduleId = value;
            }
        }
        /// <summary>
        /// Gets or sets the ResultCode value for filtering.
        /// </summary>
        public int? ResultCode
        {
            get
            {
                return this.resultCode;
            }
            set
            {
                this.resultCode = value;
            }
        }
        /// <summary>
        /// Gets or sets the compare logic to filter the The result text returned by the scheduled job..
        /// </summary>
        public Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic ResultTextCompareLogic
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
        /// Gets or sets the ResultText value for filtering.
        /// </summary>
        public string ResultText
        {
            get
            {
                return this.resultText;
            }
            set
            {
                this.resultText = value;
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
        #endregion


        #region LocalItems
        private Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic groupingLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlGroupingLogic.NULL;
        private int? jobScheduleId = null;
        private int? resultCode = null;
        private Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic resultTextCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
        private string resultText = null;
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
                if (this.jobScheduleId != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", this.jobScheduleId);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
                }
                if (this.resultCode != null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@ResultCode", this.resultCode);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value);
                }
                if (this.resultTextCompareLogic != Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@ResultTextCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogicToString(this.resultTextCompareLogic));
                    base.sqlCommand.Parameters.AddWithValue("@ResultText", this.resultText);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@ResultTextCompareLogic", System.DBNull.Value);
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
                    item.CreateUserId = sqlDr.GetInt32(2);
                    item.CreateUserName = sqlDr.GetString(3);
                    item.UpdateDate = sqlDr.GetDateTime(4);
                    item.UpdateUserId = sqlDr.GetInt32(5);
                    item.UpdateUserName = sqlDr.GetString(6);
                    item.JobScheduleId = sqlDr.GetInt32(8);
                    item.JobScheduleName = sqlDr.GetString(9);
                    item.ExecuteDateTimeStart = sqlDr.GetDateTime(10);
                    item.ExecuteDateTimeEnd = sqlDr.GetDateTime(11);
                    item.ResultCode = sqlDr.GetInt32(14);
                    item.ResultText = sqlDr.GetString(15);
                    if (!sqlDr.IsDBNull(16))
                    {
                        item.NextStart = sqlDr.GetDateTime(16);
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
                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleHistory.GetItems() while retrieving id list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleHistory.GetItems() while retrieving id list. The exception is: " + ex.Message);
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
            this.jobScheduleId = null;
            this.resultCode = null;
            this.resultTextCompareLogic = Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.Null;
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

        public int JobScheduleHistoryId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
        /// The UID of the jobs schedule recorded in this history record.
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
        /// The data and time the job execution process started.
        /// </summary>
        public DateTime ExecuteDateTimeStart
        {
            get;
            set;
        }
        /// <summary>
        /// The data and time the job execution process finished.
        /// </summary>
        public DateTime ExecuteDateTimeEnd
        {
            get;
            set;
        }
        /// <summary>
        /// The integer result code returned by the scheduled job.
        /// </summary>
        public int? ResultCode
        {
            get;
            set;
        }
        /// <summary>
        /// The result text returned by the scheduled job.
        /// </summary>
        public string ResultText
        {
            get;
            set;
        }
        /// <summary>
        /// The data and time the job is scheduled to start again after this log entry.
        /// </summary>
        public DateTime? NextStart
        {
            get;
            set;
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
        /// The UID of the jobs schedule recorded in this history record.
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
        /// The display name for property JobScheduleId.
        /// </summary>
        public string JobScheduleName
        {
            get
            {
                return this.jobScheduleName;
            }
        }
        /// <summary>
        /// The date and time the job schedule executed.
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
        /// The date and time the job finished executing.
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
                    if (!this.isNew)
                    {
                        this.isDirty = true;
                    }
                }
            }
        }
        /// <summary>
        /// The user account used to run the scheduled job.
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
        /// The string of paramaters passed on to the job executable by the job runner.
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
        /// The integer result code returned by the scheduled job.
        /// </summary>
        public int ResultCode
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
        /// The result text returned by the scheduled job.
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
        /// Free-text note about this history record.
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
        #endregion


        #region Local Items
        private int jobScheduleId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
        private string jobScheduleName = string.Empty;
        private DateTime executeDateTimeStart = DateTime.Now;
        private DateTime? executeDateTimeEnd = null;
        private string executeUserName = "";
        private string executeParams = "";
        private int resultCode = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
        private string resultText = "";
        private string note = "";
        //
        private int jobScheduleIdOld = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
        private DateTime executeDateTimeStartOld = DateTime.Now;
        private DateTime? executeDateTimeEndOld = null;
        private string executeUserNameOld = "";
        private string executeParamsOld = "";
        private int resultCodeOld = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
        private string resultTextOld = "";
        private string noteOld = "";
        #endregion


        #region Constructors
        public JobScheduleHistory(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public JobScheduleHistory(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobScheduleHistoryId) : base(dbObject, user, jobScheduleHistoryId)
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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleHistories]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@ResultCode", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@ResultTextCompareLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@ResultText", System.DBNull.Value);
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
                    this.jobScheduleId = sqlDr.GetInt32(8);
                    this.jobScheduleName = sqlDr.GetString(9);
                    this.executeDateTimeStart = sqlDr.GetDateTime(10);
                    if (!sqlDr.IsDBNull(11))
                    {
                        this.executeDateTimeEnd = sqlDr.GetDateTime(11);
                    }
                    this.executeUserName = sqlDr.GetString(12);
                    this.executeParams = sqlDr.GetString(13);
                    this.resultCode = sqlDr.GetInt32(14);
                    this.resultText = sqlDr.GetString(15);
                    this.note = sqlDr.GetString(16);
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

            if (this.executeUserName == null)
            {
                isValid = false;
                base.errorMessages.Add("The ExecuteUserName cannot be null.");
            }
            if (this.executeParams == null)
            {
                isValid = false;
                base.errorMessages.Add("The ExecuteParams cannot be null.");
            }
            if (this.resultText == null)
            {
                isValid = false;
                base.errorMessages.Add("The ResultText cannot be null.");
            }
            if (this.note == null)
            {
                isValid = false;
                base.errorMessages.Add("The Note cannot be null.");
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
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", this.jobScheduleId);
                base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeStart", this.executeDateTimeStart);
                if (this.ExecuteDateTimeEnd == null)
                {
                    base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", System.DBNull.Value);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@ExecuteDateTimeEnd", this.executeDateTimeEnd);
                }
                base.sqlCommand.Parameters.AddWithValue("@ExecuteUserName", this.executeUserName);
                base.sqlCommand.Parameters.AddWithValue("@ExecuteParams", this.executeParams);
                base.sqlCommand.Parameters.AddWithValue("@ResultCode", this.resultCode);
                base.sqlCommand.Parameters.AddWithValue("@ResultText", this.resultText);
                base.sqlCommand.Parameters.AddWithValue("@Note", this.note);
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
        /// Deleltes the item from the datastore.
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
                base.sqlCommand.CommandText = "[Service].[DeleteJobScheduleHistory]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", base.itemUid);
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
                this.jobScheduleId = this.jobScheduleIdOld;
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
        /// Writes data to backup local data items for later retrieval of the original data values.
        /// </summary>
        public override void BackupValues()
        {

            base.BackupValues();

            this.jobScheduleIdOld = this.jobScheduleId;
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
        /// De-initializes the local values to their empty values.
        /// </summary>
        public override void DeinitializeValues()
        {

            base.DeinitializeValues();

            this.jobScheduleId = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
            this.jobScheduleName = "";
            this.executeDateTimeStart = DateTime.Now;
            this.executeDateTimeEnd = null;
            this.executeUserName = "";
            this.executeParams = "";
            this.resultCode = Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger;
            this.resultText = "";
            this.note = "";

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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleHistories]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleHistoryId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleId", System.DBNull.Value);
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
        #endregion


        #region EventHandlers
        #endregion


    }


}
