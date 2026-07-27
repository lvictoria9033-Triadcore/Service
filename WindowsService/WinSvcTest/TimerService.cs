using System;
using System.Collections.Generic;
using System.Text;
using System.ServiceProcess;
using Triadcore.ClassLibrary;
using System.Timers;


namespace Triadcore.WinSvcTest
{


    public partial class TimerService : ServiceBase
    {


        #region Local Items
        private System.Timers.Timer processTimer;
        private bool mainProcessIsSafeToRun = false;
        private double timeInterval = .5;  // deafult polling interval in minutes
        private double noDbConnDefaultTimeInterval = 10;  // Polling interval to use when in an error state in minutes
        #endregion


        #region Constructor
        public TimerService()
        {
            //InitializeComponent();
            try
            {
                this.InitializeService();
            }
            catch (Exception ex)
            {
                throw new Exception("Error initializing the service. Service cannot continue. Exception: " + ex.Message);
            }
        }
        #endregion


        #region Methods
        /// <summary>
        /// Init.
        /// </summary>
        private void InitializeService()
        {
            this.mainProcessIsSafeToRun = true;
            this.SetTimer(this.timeInterval);
            return;
        }

        /// <summary>
        /// Sets the polling time interval.
        /// </summary>
        /// <param name="timeInterval">The time interval in minutes.</param>
        private void SetTimer(double timeInterval)
        {
            try
            {
                if (this.processTimer != null)
                {
                    this.processTimer.Stop();
                    this.processTimer.Dispose();
                }
                processTimer = new Timer(timeInterval * 60000.00);
                this.processTimer.Elapsed += new ElapsedEventHandler(processTimer_Elapsed);
                this.processTimer.AutoReset = true;
                this.processTimer.Start();
            }
            catch (Exception ex)
            {
                throw new Exception("Error setting the process timer.  Exception is: " + ex.Message);
            }
            try
            {
                processTimer.Start();
            }
            catch (Exception ex)
            {
                throw new Exception("Error starting the process timer.  Exception is: " + ex.Message);
            }
            return;
        }

        /// <summary>
        /// Performs service task(s).
        /// </summary>
        private void PerformSeviceTasks()
        {
            // Re-init settings and flag "this.mainProcessIsSafeToRun".
            try
            {
                this.InitializeService();
            }
            catch (Exception ex)
            {
                this.mainProcessIsSafeToRun = false;
                throw new Exception("Error setting service configuration. Service cannot continue. Exception: " + ex.Message);
            }
            if (this.mainProcessIsSafeToRun)
            {
            } // if ( this.mainProcessIsSafeToRun )
            return;
        }

        /// <summary>
        /// Runs the main process after stopping the timer and restarts the timer when the main process completes.
        /// </summary>
        private void RunTimedProcess()
        {
            // Stop timer while processing main task.
            this.processTimer.Stop();
            // Main task
            this.PerformSeviceTasks();
            // Restart timer
            this.processTimer.Start();
            return;
        }
        #endregion


        #region Event Handlers
        /// <summary>
        /// The event that fires when the timer elapses.
        /// </summary>
        private void processTimer_Elapsed(object sender, System.Timers.ElapsedEventArgs e)
        {
            this.RunTimedProcess();
        }

        protected override void OnStart(string[] args)
        {
            // For debugging: sets the service to sleep for 25 seconds to allow developer to connect to the process
            // via "Tools-->Attach To Process..." before the service reaches its 30 second "no activity" timeout.
            #if ( DEBUG )
            System.Threading.Thread.Sleep(25000);
            #endif
            //////
            base.OnStart(args);
            this.RunTimedProcess();
            return;
        }

        protected override void OnPause()
        {
            base.OnPause();
            return;
        }

        protected override void OnContinue()
        {
            base.OnContinue();
            return;
        }

        protected override void OnStop()
        {
            this.processTimer.Dispose();
            base.OnStop();
            return;
        }
        #endregion


    }


}
