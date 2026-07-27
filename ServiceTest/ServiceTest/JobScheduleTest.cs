using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace Triadcore.Service.ServiceTest
{


    public partial class JobScheduleTest : Triadcore.Base.BaseTest.BaseForm2
    {


        #region Local Items
        private Triadcore.Service.JobSchedulesQuickList dataItemsQuickList = null;
        private Triadcore.Service.JobSchedule dataItem = null;
        #endregion


        #region Constructors
        public JobScheduleTest() : base()
		{
            InitializeComponent();
            this.Init();
        }
        public JobScheduleTest(string dbName, string user, string pw) : base(dbName, user, pw)
		{
            InitializeComponent();
            this.Init();
        }
        #endregion


        #region Methods
        protected override void Init()
        {
            base.lblItemTitle.Text = "Job Schedule Test";
            this.GetQuickList();
            this.LoadQuickList();
        }

        protected override void SetDataGridViewColumns()
        {

            base.SetDataGridViewColumns();

            // Item-specific data
            dgvItemsList.Columns.Add("JobScheduleName", "Job Schedule Name");
            dgvItemsList.Columns.Add("BaseDateTime", "Base Date");
            dgvItemsList.Columns.Add("NextRunDateTime", "Next Run Date");
            dgvItemsList.Columns.Add("JobScheduleTypeName", "Type");
            dgvItemsList.Columns.Add("JobName", "Job Name");

            // Standard data
            dgvItemsList.Columns.Add("Active", "Active");
            dgvItemsList.Columns.Add("UpdateDate", "Update Date");
            dgvItemsList.Columns.Add("UpdateUserId", "Update UserId");

            // Format - Item-specific data
            dgvItemsList.Columns[0].ReadOnly = true;
            dgvItemsList.Columns["Active"].Width = 40;
            dgvItemsList.Columns["UpdateDate"].Width = 120;

            // Format - Standard data
            dgvItemsList.Columns["JobScheduleName"].Width = 200;
            dgvItemsList.Columns["BaseDateTime"].Width = 150;
            dgvItemsList.Columns["NextRunDateTime"].Width = 150;
            dgvItemsList.Columns["JobScheduleTypeName"].Width = 150;
            dgvItemsList.Columns["JobName"].Width = 200;

            //
            dgvItemsList.CellBeginEdit += new DataGridViewCellCancelEventHandler(base.dgvItemsList_CellBeginEdit);

            return;

        }

        protected override void InitItemControls()
        {

            base.InitItemControls();

            // Initialize/reset item-specific controls.
            this.txtDescription.Text = "";
            this.txtJobScheduleTypeId.Text = "";
            this.txtJobScheduleTypeName.Text = "";
            this.txtJobScheduleTypeName.ReadOnly = true;
            this.txtJobId.Text = "";
            this.txtJobName.Text = "";
            this.txtJobName.ReadOnly = true;
            this.txtBaseDateTime.Text = "";
            this.txtNextRunDateTime.Text = "";
            this.txtNextRunDateTime.ReadOnly = true;
            this.txtRunAsUser.Text = "";
            this.txtRunAsPassword.Text = "";
            this.txtInterval.Text = "";
            this.txtMonth.Text = "";
            this.txtWeekday.Text = "";
            this.txtDate.Text = "";
            this.txtTime.Text = "";
            this.chkIsRecurring.Checked = true;

            this.btnSetNextRunDate.Enabled = false;

            return;

        }

        protected override void LoadDataControls()
        {
            base.LoadDataControls();
            return;
        }

        protected override void GetQuickList()
        {

            base.GetQuickList();

            // Get list
            try
            {
                this.dataItemsQuickList = new Triadcore.Service.JobSchedulesQuickList(base.database, base.appUser);
                this.dataItemsQuickList.GetItems();
                this.btnSetNextRunDate.Enabled = false;
            }
            catch (Exception ex)
            {
                this.ShowError(ex);
                return;
            }

            this.LoadQuickList();

            return;

        }

        protected override void LoadQuickList()
        {

            base.LoadQuickList();

            int rowIndex = 0;
            int index = -1;

            base.listType = ListType.Quick;

            this.InitItemControls();

            base.txtListCount.Text = this.dataItemsQuickList.BindableItemsList.Count.ToString();

            // Load data grid view.
            try
            {
                this.dgvItemsList.Rows.Clear();
                index = 0;
                foreach (Triadcore.Service.JobSchedulesQuickListItem qli in this.dataItemsQuickList.BindableItemsList)
                {
                    rowIndex = dgvItemsList.Rows.Add();
                    dgvItemsList[0, rowIndex].Value = qli.ItemUid.ToString();
                    dgvItemsList[1, rowIndex].Value = qli.JobScheduleName;
                    dgvItemsList[2, rowIndex].Value = qli.BaseDateTime.ToString();
                    dgvItemsList[3, rowIndex].Value = qli.NextRun.ToString();
                    dgvItemsList[4, rowIndex].Value = qli.JobScheduleTypeName;
                    dgvItemsList[5, rowIndex].Value = qli.JobName;
                    dgvItemsList[6, rowIndex].Value = qli.Active.ToString();
                    dgvItemsList[7, rowIndex].Value = qli.UpdateDate.ToString();
                    dgvItemsList[8, rowIndex].Value = qli.UpdateUserId.ToString();
                    index++;
                }
            }
            catch (Exception ex)
            {
                this.ShowError("An exception occured in GetQuickList() while loading the data grid. Exception is: " + ex.Message);
                return;
            }

            return;

        }

        protected override void GetSelectedItem(DataGridViewRow selectedRow)
        {

            base.GetSelectedItem(selectedRow);

            try
            {
                this.dataItem = new JobSchedule(this.database, this.appUser, Convert.ToInt32(selectedRow.Cells[0].Value));
                this.dataItem.GetItem();
                this.LoadItemDetails();
            }
            catch(Exception ex)
            {
                MessageBox.Show("Error retrieving data item: " + ex.Message);
            }

            return;

        }

        protected override void LoadItemDetails()
        {

            //---------------------------------------------------------------------
            base.LoadItemDetails();
            base.txtItemUid.Text = this.dataItem.ItemUid.ToString();
            base.txtItemName.Text = this.dataItem.JobScheduleName;
            base.chkIsActive.Checked = this.dataItem.Active;

            //---------------------------------------------------------------------
            this.txtDescription.Text = this.dataItem.Description;
            this.txtJobScheduleTypeId.Text = this.dataItem.JobScheduleTypeId.ToString();
            this.txtJobScheduleTypeName.Text = this.dataItem.JobScheduleTypeName;
            this.txtJobId.Text = this.dataItem.JobId.ToString();
            this.txtJobName.Text = this.dataItem.JobName;
            this.txtBaseDateTime.Text = this.dataItem.BaseDateTime.ToString();
            this.txtNextRunDateTime.Text = this.dataItem.NextStartDateTime.ToString();
            this.txtRunAsUser.Text = this.dataItem.RunAsUser;
            this.txtRunAsPassword.Text = this.dataItem.RunAsPassword;
            this.txtInterval.Text = this.dataItem.IntervalNumber.ToString();
            this.txtMonth.Text = this.dataItem.MonthNumber.ToString();
            this.txtWeekday.Text = this.dataItem.WeekdayIndex.ToString();
            this.txtDate.Text = this.dataItem.DateNumber.ToString();
            this.txtTime.Text = this.dataItem.TimeNumber.ToString();
            this.chkIsRecurring.Checked = this.dataItem.IsRecurring;
            this.btnSetNextRunDate.Enabled = true;

            //-------------------------------------------------------------
            base.txtCreateDate.Text = this.dataItem.CreateDate.ToShortDateString();
            base.txtCreateUserId.Text = this.dataItem.CreateUserId.ToString();
            base.txtCreateUserName.Text = this.dataItem.CreateUserName;
            base.txtUpdateDate.Text = this.dataItem.UpdateDate.ToShortDateString();
            base.txtUpdateUserId.Text = this.dataItem.UpdateUserId.ToString();
            base.txtUpdateUserName.Text = this.dataItem.UpdateUserName;
            base.txtRecordComment.Text = this.dataItem.RecordComment;
            base.btnUpdate.Enabled = true;
            base.btnDelete.Enabled = true;

            return;

        }

        protected override void UpdateItem()
        {

            this.dataItem.JobScheduleName = base.txtItemName.Text;
            this.dataItem.Description=this.txtDescription.Text;
            this.dataItem.JobScheduleTypeId = Convert.ToInt32(this.txtJobScheduleTypeId.Text);
            this.dataItem.JobId = Convert.ToInt32(this.txtJobId.Text);
            this.dataItem.BaseDateTime = Convert.ToDateTime(this.txtBaseDateTime.Text);
            this.dataItem.RunAsUser = this.txtRunAsUser.Text ;
            this.dataItem.RunAsPassword = this.txtRunAsPassword.Text;
            if (this.txtInterval.Text.Trim() != "")
            {
                this.dataItem.IntervalNumber = Convert.ToInt32(this.txtInterval.Text);
            }
            else
            {
                this.dataItem.IntervalNumber = null;
            }
            if (this.txtMonth.Text.Trim() != "")
            {
                this.dataItem.MonthNumber = Convert.ToInt32(this.txtMonth.Text);
            }
            else
            {
                this.dataItem.MonthNumber = null;
            }
            if (this.txtWeekday.Text.Trim() != "")
            {
                this.dataItem.WeekdayIndex = Convert.ToInt32(this.txtWeekday.Text);
            }
            else
            {
                this.dataItem.WeekdayIndex = null;
            }
            if (this.txtDate.Text.Trim() != "")
            {
                this.dataItem.DateNumber = Convert.ToInt32(this.txtDate.Text);
            }
            else
            {
                this.dataItem.DateNumber = null;
            }
            if (this.txtTime.Text.Trim() != "")
            {
                this.dataItem.TimeNumber = Convert.ToInt32(this.txtTime.Text);
            }
            else
            {
                this.dataItem.TimeNumber = null;
            }
            this.dataItem.IsRecurring = this.chkIsRecurring.Checked;
            this.dataItem.RecordComment = "LV Test";

            //---------------------------------------------------------------------------
            base.UpdateItem();
            try
            {
                this.dataItem.UpdateItem();
                this.InitControls();
                this.LoadItemDetails();
            }
            catch(Exception ex)
            {
                string e = "";
                if (this.dataItem.ErrorMessages.Count > 0)
                {
                    
                    foreach (string err in this.dataItem.ErrorMessages)
                    {
                        e += "\r\n" + err;
                    }
                }
                MessageBox.Show("Error updating data: " + ex.Message + " " + e);
                this.rtxtClientMessage.Text += e;
            }

            return;
        }

        protected override void NewItem()
        {

            base.NewItem();

            this.InitItemControls();

            base.txtItemName.Enabled = true;
            base.txtItemName.ReadOnly = false;

            this.txtNextRunDateTime.Enabled = false;
            this.btnSetNextRunDate.Enabled = false;

            this.dataItem = new JobSchedule(base.database, base.appUser);

            return;

        }

        protected override void DeleteItem()
        {

            base.DeleteItem();

            try
            {
                this.dataItem.DeleteItem();
                this.btnSetNextRunDate.Enabled = false;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error deleting data: " + ex.Message);
            }

            base.btnUpdate.Enabled = false;
            base.btnDelete.Enabled = false;

            this.GetQuickList();

            return;

        }

        protected override void SetActiveIndicator()
        {
            base.SetActiveIndicator();
            try
            {
                this.dataItem.SetActiveIndicator(!base.chkIsActive.Checked);
                this.LoadItemDetails();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error setting data active flag: " + ex.Message);
            }
            return;
        }

        private void SetNextRunDate()
        {
            try
            {
                string dt = this.dataItem.UpdateJobScheduleNextStart().ToString();
                this.GetQuickList();
                this.dataItem.GetItem();
                this.LoadItemDetails();
                base.rtxtClientMessage.Text = dt;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error setting next scheduled runtime: " + ex.Message);
            }
            return;
        }
        #endregion


        #region Event Handlers
        private void btnSetNextRunDate_Click(object sender, EventArgs e)
        {
            this.SetNextRunDate();
            return;
        }
        #endregion


    }


}
