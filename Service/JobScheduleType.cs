/******************************************************************************************************************************************************
* Name        : JobScheduleType.cs
* Purpose     : Provides JobScheduleType support.
* Create Date : 2026.10.22
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

	
	public class JobScheduleTypesQuickList : Triadcore.Base.QuickListBase
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
		/// JobScheduleTypeName compare logic for filtering.
		/// </summary>
		public string JobScheduleTypeNameCompareLogic
		{
			get
			{
				return this.jobScheduleTypeNameCompareLogic;
			}
			set
			{
				this.jobScheduleTypeNameCompareLogic = value;
			}
		}
		/// <summary>
		/// The unique job schedule type name.
		/// </summary>
		public string JobScheduleTypeName
		{
			get
			{
				return this.jobScheduleTypeName;
			}
			set
			{
				if (this.jobScheduleTypeName != value)
				{
					this.jobScheduleTypeName = value;
				}
			}
		}
		/// <summary>
		/// InstanceDescription compare logic for filtering.
		/// </summary>
		public string InstanceDescriptionCompareLogic
		{
			get
			{
				return this.instanceDescriptionCompareLogic;
			}
			set
			{
				this.instanceDescriptionCompareLogic = value;
			}
		}
		/// <summary>
		/// A markup template of how the type is described.
		/// </summary>
		public string InstanceDescription
		{
			get
			{
				return this.instanceDescription;
			}
			set
			{
				if (this.instanceDescription != value)
				{
					this.instanceDescription = value;
				}
			}
		}
        /// <summary>
        /// Gets a list of data items converted from Triadcore.Base.QuickListItemBase{}.
        /// Provided for convenient data binding. Converted at runtime.
        /// </summary>
        public List<Triadcore.Service.JobScheduleTypesQuickListItem> BindableJobScheduleTypesList
        {
            get
            {
                List<Triadcore.Service.JobScheduleTypesQuickListItem> listOut = new List<Triadcore.Service.JobScheduleTypesQuickListItem>();
                foreach (Triadcore.Service.JobScheduleTypesQuickListItem c in base.itemsQuickList)
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
        private string jobScheduleTypeNameCompareLogic = null; 
		private string jobScheduleTypeName = null;
		private string instanceDescriptionCompareLogic = null; 
		private string instanceDescription = null;
        //
        protected string acbBuildDate = "2026.10.22";
        #endregion


        #region Constructors
        public JobScheduleTypesQuickList(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleTypes]";
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
			    base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value);
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
				if (this.jobScheduleTypeNameCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@jobScheduleTypeNameCompareLogic", this.jobScheduleTypeNameCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@jobScheduleTypeNameCompareLogic", System.DBNull.Value);
				}
				if (this.jobScheduleTypeName != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeName", this.jobScheduleTypeName);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeName", System.DBNull.Value);
				}
				if (this.instanceDescriptionCompareLogic != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@instanceDescriptionCompareLogic", this.instanceDescriptionCompareLogic);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@instanceDescriptionCompareLogic", System.DBNull.Value);
				}
				if (this.instanceDescription != null)
				{
					base.sqlCommand.Parameters.AddWithValue("@InstanceDescription", this.instanceDescription);
				}
				else
				{
					base.sqlCommand.Parameters.AddWithValue("@InstanceDescription", System.DBNull.Value);
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
                    Triadcore.Service.JobScheduleTypesQuickListItem item = new Triadcore.Service.JobScheduleTypesQuickListItem(uid);
                    item.CreateDate = sqlDr.GetDateTime(1);
					item.CreateUserId = sqlDr.GetInt32(2); // Fkey
					item.CreateUserName = sqlDr.GetString(3);  // Fkey alias to CreateUserId
					item.UpdateDate = sqlDr.GetDateTime(4);
					item.UpdateUserId = sqlDr.GetInt32(5); // Fkey
					item.UpdateUserName = sqlDr.GetString(6);  // Fkey alias to UpdateUserId
					item.Active = sqlDr.GetBoolean(7);
					item.JobScheduleTypeName = sqlDr.GetString(8);
					item.InstanceDescription = sqlDr.GetString(10);
                    base.itemsQuickList.Add(item);
                    base.uidList.Add(uid);
                    lastUid = uid;
                }
                sqlDr.Close();
            }
            catch (SqlException sqlEx)
            {
                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleTypesQuickList.GetItems() while retrieving data list. The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleTypesQuickList.GetItems() while retrieving data list. The exception is: " + ex.Message);
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
            this.jobScheduleTypeNameCompareLogic = null;
			this.jobScheduleTypeName = null;
			this.instanceDescriptionCompareLogic = null;
			this.instanceDescription = null;

            return;

        }

        /// <summary>
        /// Inserts a "NULL" QuickListItem{} to the front of the quicklist. ItemUid is set to the static default integer Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger.
        /// (Use for adding a null option to a select list.)
        /// </summary>
        public override void InsertNullToList()
        {
            Triadcore.Service.JobScheduleTypesQuickListItem newItem = new Triadcore.Service.JobScheduleTypesQuickListItem(Triadcore.ClassLibrary.Utilities.DefaultInitializeInteger);
            this.itemsQuickList.Insert(0, newItem);
        }
        #endregion


    }


	public class JobScheduleTypesQuickListItem : Triadcore.Base.QuickListItemBase
    {

        /// <summary>
	    /// The JobScheduleType unique identifier.
	    /// </summary>    
        public int JobScheduleTypeId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// The unique job schedule type name.
		/// </summary>
		public string JobScheduleTypeName
		{
			get;
			set;
		}
		/// <summary>
		/// A markup template of how the type is described.
		/// </summary>
		public string InstanceDescription
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
                return "2026.10.22";
            }
        }

        public JobScheduleTypesQuickListItem(int itemUid) : base(itemUid)
        {
        }

    }



	public class JobScheduleType : Triadcore.Base.ItemBase
    {


        #region Properties
        /// <summary>
        /// Gets the item unique ID in the datastore.
        /// </summary>
        public int JobScheduleTypeId
        {
            get
            {
                return base.itemUid;
            }
        }
        /// <summary>
		/// The unique job schedule type name..
		/// </summary>
		public string JobScheduleTypeName
		{
			get
			{
				return this.jobScheduleTypeName;
			}
			set
			{
				if (this.jobScheduleTypeName != value)
				{
					this.jobScheduleTypeName = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// The job schedule type description..
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
		/// A markup template of how the type is described..
		/// </summary>
		public string InstanceDescription
		{
			get
			{
				return this.instanceDescription;
			}
			set
			{
				if (this.instanceDescription != value)
				{
					this.instanceDescription = value;
					if (!this.isNew)
					{
						this.isDirty = true;
					}
				}
			}
		}
		/// <summary>
		/// Free-text  notes..
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
        private string jobScheduleTypeName = "";
		private string description = "";
		private string instanceDescription = "";
		private string note = "";
		//
		private string jobScheduleTypeNameOld = "";
		private string descriptionOld = "";
		private string instanceDescriptionOld = "";
		private string noteOld = "";
        //
        protected string acbBuildDate = "2026.10.22";
        #endregion


        #region Constructors
        public JobScheduleType(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user) : base(dbObject, user)
        {
        }
        public JobScheduleType(Triadcore.ClassLibrary.DataConn dbObject, Triadcore.Base.AppUser user, int jobScheduleTypeId) : base(dbObject, user, jobScheduleTypeId)
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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleTypes]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", base.itemUid);
                base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value); // FKey
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeNameCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeName", System.DBNull.Value); // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@InstanceDescriptionCompareLogic", System.DBNull.Value);  // forced DB Null
				base.sqlCommand.Parameters.AddWithValue("@InstanceDescription", System.DBNull.Value); // forced DB Null
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
					this.jobScheduleTypeName = sqlDr.GetString(8);
					this.description = sqlDr.GetString(9);
					this.instanceDescription = sqlDr.GetString(10);
					this.note = sqlDr.GetString(11);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleType.GetItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.GetItem(). The exception is: " + ex.Message);

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
                base.sqlCommand.CommandText = "[Service].[UpdateJobScheduleType]";
			
                #region Set stored procedure parameters
                if (!base.isNew)
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", base.itemUid);
                }
                else
                {
                    base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value);
                }
                base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", base.updateUserId);
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeName", this.jobScheduleTypeName);
				base.sqlCommand.Parameters.AddWithValue("@Description", this.description);
				base.sqlCommand.Parameters.AddWithValue("@InstanceDescription", this.instanceDescription);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleType.UpdateItem(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.UpdateItem() when attempting to retrieve data. The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.UpdateItem() when attempting to use method GetItem() to refresh the data after an apparent successful update. The exception is: " + ex.Message);
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
                base.sqlCommand.CommandText = "[Service].[SetJobScheduleTypeActivation]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", base.itemUid);
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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleType.SetActiveIndicator(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.SetActiveIndicator(). The exception is: " + ex.Message);

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
                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.SetActiveIndicator(bool) when attempting to use method GetItem() to refresh the data after an apparent successful update to set the item ACTIVE flag. The exception is: " + ex.Message);
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
            string deleteNote = "JobScheduleTypeName=" + this.jobScheduleTypeName.ToString() + ".";

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
                base.sqlCommand.CommandText = "[Service].[DeleteJobScheduleType]";

                #region Set stored procedure parameters
                base.sqlCommand.Parameters.Clear();
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", base.itemUid);
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
                    throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleType.DeleteItem().  The error code is: " + sqlEx.Number.ToString() + ". The execption is: " + sqlEx.Message);
                }
            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.DeleteItem(). The exception is: " + ex.Message);

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

            // JobScheduleTypeName - empty string not allowed
			if (this.jobScheduleTypeName == null || this.jobScheduleTypeName.Trim() == "")
			{
				isValid = false;
				base.errorMessages.Add("Field [JobScheduleTypeName] cannot be null or blank.");
			}
			
			if (isValid && this.IsDuplicate())
			{
				isValid = false;
				base.errorMessages.Add("The item with unique field [JobScheduleTypeName] already exists in the datastore.");
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
                base.sqlCommand.CommandText = "[Service].[GetJobScheduleTypes]";

                // Set stored procedure parameters.
                base.sqlCommand.Parameters.AddWithValue("@GroupingLogic", System.DBNull.Value);  // forced DB Null
                base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeId", System.DBNull.Value);
			    base.sqlCommand.Parameters.AddWithValue("@CreateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@CreateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateDate", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@UpdateUserId", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@Active", System.DBNull.Value); 
				// Unique field
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeNameCompareLogic", Triadcore.ClassLibrary.DataConnUtilities.SqlCompareLogic.EqualTo.ToString());
				base.sqlCommand.Parameters.AddWithValue("@JobScheduleTypeName", this.jobScheduleTypeName);
				base.sqlCommand.Parameters.AddWithValue("@InstanceDescriptionCompareLogic", System.DBNull.Value);
				base.sqlCommand.Parameters.AddWithValue("@InstanceDescription", System.DBNull.Value);

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

                throw new Exception("A SQL exception occurred in Triadcore.Service.JobScheduleType.IsDuplicate(). The error code is: " + sqlEx.Number.ToString() + ". The exception is: " + sqlEx.Message);

            }
            catch (Exception ex)
            {

                throw new Exception("An exception occurred in Triadcore.Service.JobScheduleType.IsDuplicate(). The exception is: " + ex.Message);

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

            this.jobScheduleTypeNameOld = this.jobScheduleTypeName;
			this.descriptionOld = this.description;
			this.instanceDescriptionOld = this.instanceDescription;
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
                this.jobScheduleTypeName = this.jobScheduleTypeNameOld;
				this.description = this.descriptionOld;
				this.instanceDescription = this.instanceDescriptionOld;
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

            this.jobScheduleTypeName = "";
			this.description = "";
			this.instanceDescription = "";
			this.note = "";

            this.BackupValues();

            return;

        }
        #endregion


        #region EventHandlers
        #endregion


    }


}
