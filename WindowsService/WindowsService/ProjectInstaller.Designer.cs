namespace WindowsService
{
    partial class ProjectInstaller
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.WindowsServiceProcessInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.WindowsServiceInstaller = new System.ServiceProcess.ServiceInstaller();
            // 
            // WindowsServiceProcessInstaller
            // 
            this.WindowsServiceProcessInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.WindowsServiceProcessInstaller.Password = null;
            this.WindowsServiceProcessInstaller.Username = null;
            // 
            // WindowsServiceInstaller
            // 
            this.WindowsServiceInstaller.Description = "STV basic Windows Service";
            this.WindowsServiceInstaller.DisplayName = "STV Windows Service";
            this.WindowsServiceInstaller.ServiceName = "WindowsService";
            this.WindowsServiceInstaller.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.WindowsServiceProcessInstaller,
            this.WindowsServiceInstaller});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller WindowsServiceProcessInstaller;
        private System.ServiceProcess.ServiceInstaller WindowsServiceInstaller;
    }
}