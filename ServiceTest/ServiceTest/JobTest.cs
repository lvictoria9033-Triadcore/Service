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


    public partial class JobTest : Triadcore.Base.BaseTest.BaseForm2
    {


        #region Local Items
        private Triadcore.Service.JobsQuickList dataItemsQuickList = null;
        private Triadcore.Service.Job dataItem = null;
        #endregion


        #region Constructors
        public JobTest() : base()
        {
            InitializeComponent();
            this.Init();
        }
        public JobTest(string dbName, string user, string pw) : base(dbName, user, pw)
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
            dgvItemsList.Columns.Add("JobName", "Job Schedule Name");
            dgvItemsList.Columns.Add("Description", "Type");

            // Standard data
            dgvItemsList.Columns.Add("Active", "Active");
            dgvItemsList.Columns.Add("UpdateDate", "Update Date");
            dgvItemsList.Columns.Add("UpdateUserId", "Update UserId");

            // Format - Item-specific data
            dgvItemsList.Columns[0].ReadOnly = true;
            dgvItemsList.Columns["Active"].Width = 40;
            dgvItemsList.Columns["UpdateDate"].Width = 120;

            // Format - Standard data
            dgvItemsList.Columns["JobName"].Width = 200;
            dgvItemsList.Columns["Description"].Width = 400;

            //
            dgvItemsList.CellBeginEdit += new DataGridViewCellCancelEventHandler(base.dgvItemsList_CellBeginEdit);

            return;

        }

        protected override void InitItemControls()
        {

            base.InitItemControls();

            // Initialize/reset item-specific controls.
            this.txtFriendlyName.Text = "";
            this.txtDescription.Text = "";
            this.txtExecPath.Text = "";
            this.txtExecFile.Text = "";
            this.txtParamString.Text = "";
            this.txtSortText.Text = "";

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
                this.dataItemsQuickList = new Triadcore.Service.JobsQuickList(base.database, base.appUser);
                this.dataItemsQuickList.GetItems();
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
                foreach (Triadcore.Service.JobsQuickListItem qli in this.dataItemsQuickList.BindableItemsList)
                {
                    rowIndex = dgvItemsList.Rows.Add();
                    dgvItemsList[0, rowIndex].Value = qli.ItemUid.ToString();
                    dgvItemsList[1, rowIndex].Value = qli.JobName;
                    dgvItemsList[2, rowIndex].Value = qli.Description;
                    dgvItemsList[3, rowIndex].Value = qli.Active.ToString();
                    dgvItemsList[4, rowIndex].Value = qli.UpdateDate.ToString();
                    dgvItemsList[5, rowIndex].Value = qli.UpdateUserId.ToString();
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
                this.dataItem = new Job(this.database, this.appUser, Convert.ToInt32(selectedRow.Cells[0].Value));
                this.dataItem.GetItem();
                this.LoadItemDetails();
            }
            catch (Exception ex)
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
            base.txtItemName.Text = this.dataItem.JobName;
            base.chkIsActive.Checked = this.dataItem.Active;

            //---------------------------------------------------------------------
            this.txtDescription.Text = this.dataItem.Description;
            this.txtFriendlyName.Text = this.dataItem.JobFriendlyName;
            this.txtBasePath.Text = this.dataItem.BasePath;
            this.txtExecPath.Text = this.dataItem.ExecPath;
            this.txtExecFile.Text = this.dataItem.ExecFile;
            this.txtParamString.Text = this.dataItem.ParamString;
            this.txtSortText.Text = this.dataItem.SortText;

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

            this.dataItem.JobName = base.txtItemName.Text;
            this.dataItem.Description = this.txtDescription.Text;
            this.dataItem.JobFriendlyName = this.txtFriendlyName.Text;
            this.dataItem.ExecPath = this.txtExecPath.Text;
            this.dataItem.ExecFile = this.txtExecFile.Text;
            this.dataItem.ParamString = this.txtParamString.Text;
            this.dataItem.SortText = this.txtSortText.Text;

            this.dataItem.RecordComment = "LV Test";

            //---------------------------------------------------------------------------
            base.UpdateItem();
            try
            {
                this.dataItem.UpdateItem();
                this.InitControls();
                this.LoadItemDetails();
            }
            catch (Exception ex)
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

            this.txtDescription.ReadOnly = false;
            this.txtFriendlyName.ReadOnly = false;
            this.txtExecPath.ReadOnly = false;
            this.txtExecFile.ReadOnly = false;
            this.txtParamString.ReadOnly = false;
            this.txtSortText.ReadOnly = false;

            this.dataItem = new Job(base.database, base.appUser);

            return;

        }

        protected override void DeleteItem()
        {

            base.DeleteItem();

            try
            {
                this.dataItem.DeleteItem();
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
        #endregion


        #region Event Handlers
        #endregion


    }


}
