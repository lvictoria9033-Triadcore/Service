using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Data.SqlClient;
using Triadcore.ClassLibrary;
using System.ServiceProcess;


namespace Triadcore.WinSvcTest
{


    public partial class Form1 : Form
    {


        public Form1()
        {
            InitializeComponent();
            this.Go();
        }

        private void Go()
        {

   

            try
            {
                try
                {
                    //int i = Convert.ToInt32("rrr");
                }
                catch (Exception ex1)
                {
                    throw new Exception("This occured in method Go() line 74. The exception message is: " + ex1.Message);
                }

                MessageBox.Show("success");
            }
            catch (SqlException sqlEx)
            {
                MessageBox.Show("The sql exception message is: " + sqlEx.Message);
            }
            catch (Exception ex)
            {
                MessageBox.Show("The exception message is: " + ex.Message);
            }
            finally
            {

            }

            string c = Concat("err", "dkdkd");
            c = Concat(15,20);

            FileInfo fi = new FileInfo(System.Reflection.MethodInfo.GetCurrentMethod().DeclaringType.Assembly.Location);
            this.svcConfig = new Triadcore.ServiceConfiguration.ServiceConfiguration(fi.DirectoryName + "\\WinSvcConfig.xml", false);
            this.svcConfig.ThrowExceptionOnMissingNode = false;
            //MessageBox.Show(this.svcConfig.LoggingDestination.ToString());
            //MessageBox.Show(this.svcConfig.RootNodeName);
            //MessageBox.Show(this.svcConfig.TimerInterval.ToString());
            //MessageBox.Show(this.svcConfig.XmlConfigFilePath);
            Triadcore.ClassLibrary.Logging log = new Triadcore.ClassLibrary.Logging(fi.DirectoryName);
            log.PrimaryLoggingDestination = Triadcore.ClassLibrary.LoggingDestination.LocalEventLog;
            log.LogInfo("infor test");
            Triadcore.ClassLibrary.LocalMachine localMachine = new Triadcore.ClassLibrary.LocalMachine();
            MessageBox.Show("Machine name: " + localMachine.MachineName);
        }

        private string Concat(string word1, string word2)
        {
            return "a";
        }

        private string Concat(int num1, int num2)
        {
            return "b";
        }

    }
}