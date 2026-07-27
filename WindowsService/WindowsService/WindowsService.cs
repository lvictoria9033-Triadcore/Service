/*****************************************************************************************************************************************
 * Name: WindowsService.cs
 * 
 * Author: Leonard Victoria
 * 
 * Create Date: 2007.07.13
 * 
 * Purpose: Provides basic Windows service functionality.  Primary purpose is to establish a timer and lauch service processes/code
 *          at the end of a timed interval.
 * 
 * Justification: For ease of use and reduced coding for a development environment that currently only has 1 .NET programmer.
 * 
 * Reason: The master service that runs 24/7 as a processing engine.
 * 
 * Assumptions: 
 *      1. The root node of the XML configuration file is <Configuration></Configuration>.
 *      2. The service has write access to the directory that holds its .exe.
 * 
 * Special Notes:
 *      Instructions for debugging: 
 *          1. Stop the service in Start-->Settings-->Control Panel-->Administrative Tools-->Services.
 *          2. Use open a command prompt or VS command prompt.
 *          3. Run "InstallUtil.exe \u <assembly name/path>" to uninstall the service, if already installed.
 *          4. Build the solution.
 *          5. Run "InstallUtil.exe <assembly name/path>" to install the service.
 *          6. Start the service in Start-->Settings-->Control Panel-->Administrative Tools-->Services.
 *          7. In Visual Studio go to Tools-->Attach Process....
 *          8. In the Attach To Process dialog, select the process from the Available Processes window.
 *          9. Click the Attach button.
 *          10. Set breakpoints in the code.
 *      By default, this will log to the local as a separate logging process when the configuration for the application
 *      message logging has not yet been implemented.
 * 
 *****************************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.ServiceProcess;
using System.Text;
using System.Resources;
using System.Reflection;
using System.Timers;
using System.IO;
using System.Xml.XPath;
using Triadcore.ClassLibrary;


namespace WindowsService
{
    

    /// <summary>
    /// Provides basic Windows service functionality.  Primary purpose is to establish a timer and lauch service processes/code
    /// at the end of a timed interval.
    /// </summary>
    public partial class WindowsService : ServiceBase
    {


        #region Local Items
        // The timer that causes the processTimer_Elapsed() event to fire.
        private System.Timers.Timer processTimer = null;
        // Default timer interval.
        private int defaultTimerInterval = 300; // in seconds
        // Indicates that the process(es) is (are) safe to run.
        private bool mainProcessIsSafeToRun = false;
        // The last System.Exception experienced by the service.
        private System.Exception lastException = null;
        // Storing and updating service configs.
        private Triadcore.Service.ServiceConfiguration svcConfig = null;
        // Object that holds information about this assembly.
        Assembly thisAssembly = System.Reflection.MethodInfo.GetCurrentMethod().DeclaringType.Assembly;
        // The service file location.
        private string servicePath = "";
        // The name of teh configuration file.
        private string configFileName = "WinSvcConfig.xml";
        // Logging info and errors.
        private Triadcore.ClassLibrary.Logging log = null;
        // Local machine and user login information.
        private Triadcore.ClassLibrary.LocalMachine localMachine = new Triadcore.ClassLibrary.LocalMachine();
        #endregion
        

        #region Constructor
        public WindowsService()
        {

            InitializeComponent();

            // Init
            try
            {
                this.InitializeService();
                this.lastException = null;
            }
            catch (Exception ex)
            {
                // Log to the local machine event log.
                System.Diagnostics.EventLog.WriteEntry("Application", "An exception occured while calling the method InitializeService(). The exception message is:" + ex.Message, EventLogEntryType.Error);
                throw new Exception("An exception occured while calling the method InitializeService(). The exception message is:" + ex.Message);
            }

            // Set configs
            try
            {
                this.SetConfigurations();
                this.lastException = null;
            }
            catch (Exception ex)
            {
                // Log to the local machine event log.
                this.lastException = ex;
                System.Diagnostics.EventLog.WriteEntry("Application", "An exception occured while calling the method SetServiceConfigurations(). The exception message is:" + ex.Message, EventLogEntryType.Error);
            }

            // Make a message entry. Object log{} was expected to be instantiated and configured in this.Setconfigurations().
            this.log.LogInfo(this.thisAssembly.Location + " successfully initiated on machine " + this.localMachine.MachineName + " from config data from " + this.svcConfig.XmlConfigFilePath + ".");

            return;

        }
        #endregion


        #region Methods
        /// <summary>
        /// Gets service configuration settings.
        /// </summary>
        private void InitializeService()
        {
            this.mainProcessIsSafeToRun = true;
            FileInfo fi = new FileInfo(this.thisAssembly.Location);
            // Set the path to the configuration file.
            try
            {
                this.servicePath = fi.DirectoryName.TrimEnd('\\') + "\\";
            }
            catch (Exception ex)
            {
                this.mainProcessIsSafeToRun = false;
                throw new Exception("An exception occured while attempting to determine the directory path to the assembly. The exception message is: " + ex.Message);
            }
            return;
        }

        /// <summary>
        /// Retrieves and sets the service configurations from the configuration file.
        /// </summary>
        private void SetConfigurations()
        {

            this.mainProcessIsSafeToRun = true;

            // Service configuration file.
            try
            {
                this.svcConfig = new Triadcore.Service.ServiceConfiguration(this.servicePath + this.configFileName);
            }
            catch (Exception ex)
            {
                this.mainProcessIsSafeToRun = false;
                throw new Exception("An exception occured attempting to set the service configurations. The exception message is: " + ex.Message);
            }

            // Logging preference.
            try
            {
                this.log = new Triadcore.ClassLibrary.Logging(this.servicePath);
                this.log.PrimaryLoggingDestination = svcConfig.LoggingDestination;
            }
            catch (Exception ex)
            {
                this.mainProcessIsSafeToRun = false;
                throw new Exception("An exception occured while instantiating a new Logging.Logging{} object. The exception message is: " + ex.Message);
            }

            // Timer interval.
            try
            {
                this.SetTimer(this.svcConfig.TimerInterval);
            }
            catch (Exception ex)
            {
                this.mainProcessIsSafeToRun = false;
                this.log.LogException(new Exception("An exception occured while setting the service timer interval.", ex));
                throw new Exception("An exception occured while setting the service timer interval. The exception message is: " + ex.Message);
            }

            return;

        }

        /// <summary>
        /// Performs service task(s).
        /// </summary>
        private void PerformSeviceTasks()
        {

            // Instantiate the objects that will perform useful work and execute them here.
            // The base class for the objects will have a "RunJob()" public/protected method.
            // Must test to ensure that the object inherits from the base class.
            // Ensure the base class has a "LastException" or "LastErrorMessage" property.

            if (this.mainProcessIsSafeToRun)
            {

                this.lastException = null;

                try
                {
                    // test
                    //this.log.LogInfo("The STV Windows Service is running at " + DateTime.Now.ToString() + ".");
                }
                catch (Exception ex)
                {
                    this.lastException = ex;
                    this.log.LogException(ex);
                }

            } // if ( this.mainProcessIsSafeToRun )

            return;

        }

        /// <summary>
        /// Sets the wakeup time interval.
        /// </summary>
        /// <param name="timeInterval">The time interval in seconds.</param>
        private void SetTimer(int timerInterval)
        {

            if (timerInterval < 1)
            {
                this.log.LogError("The speficfied service timer interval is invald (" + timerInterval.ToString() + "). The timer interval is being reset to the default of " + this.defaultTimerInterval.ToString() + " seconds.");
                timerInterval = this.defaultTimerInterval;
            }

            try
            {
                if (this.processTimer != null)
                {
                    this.processTimer.Stop();
                    this.processTimer.Dispose();
                }
                processTimer = new Timer(timerInterval * 1000);
                this.processTimer.Elapsed += new ElapsedEventHandler(processTimer_Elapsed);
                this.processTimer.AutoReset = true;
                this.processTimer.Start();
            }
            catch (Exception ex)
            {
                this.lastException = ex;
                this.log.LogException(new Exception("An exception occured attempting to set the service timer interval.", ex));
            }

            return;

        }

        /// <summary>
        /// Runs the main process after stopping the timer and restarts the timer when the main process completes.
        /// </summary>
        private void RunTimedProcess()
        {

            try
            {
                // Stop timer while processing main task.
                this.processTimer.Stop();
                // Main task
                this.PerformSeviceTasks();
            }
            catch (Exception ex)
            {
                this.lastException = ex;
                this.log.LogException( new Exception("An exception occured in method RunTimedProcess().", ex));
                // Restart timer
                this.processTimer.Start();
            }

            return;

        }
        #endregion
        

        #region Event Handlers
        private void processTimer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            this.RunTimedProcess();
            return;
        }

        protected override void OnStart(string[] args)
        {
            // ------------------------------------------------------------------------------------------------------------
            // For debugging: sets the service to sleep for 25 seconds to allow developer to connect to the process
            // via "Tools-->Attach To Process..." before the service reaches its 30 second "no activity" timeout.
            #if ( DEBUG )
                System.Threading.Thread.Sleep(25000);
            #endif
            // -------------------------------------------------------------------------------------------------------------
            base.OnStart(args);
            log.LogInfo("Service started on " + DateTime.Now.ToString() + ".");
            this.RunTimedProcess();
            return;
        }

        protected override void OnPause()
        {
            base.OnPause();
            log.LogInfo("Service paused on " + DateTime.Now.ToString() + ".");
            return;
        }

        protected override void OnContinue()
        {
            base.OnContinue();
            log.LogInfo("Service continued on " + DateTime.Now.ToString() + ".");
            return;
        }

        protected override void OnStop()
        {
            log.LogInfo("Service stopping on " + DateTime.Now.ToString() + ".");
            this.processTimer.Dispose();
            base.OnStop();
            return;
        }
        #endregion

    }

}
