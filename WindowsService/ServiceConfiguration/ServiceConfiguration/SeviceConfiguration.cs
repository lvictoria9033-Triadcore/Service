/***********************************************************************************************************************************
 * Name: XmlConfiguration.cs
 * Author: Leonard Victoria
 * Purpose: Provides a class for reading and creating a configuration file in XML format.
 * Reason: For ease of use and reduced coding for a development environment that currently only has 1 .NET programmer.
 * Assumptions: The root node of the XML configuration file is <Configuration></Configuration>.
 ***********************************************************************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Xml.XPath;
using System.IO;
using Triadcore;
using Triadcore.ClassLibrary;


namespace Triadcore.Service
{


    /// <summary>
    /// Provides a class for reading the service configuration file.
    /// </summary>
    public class ServiceConfiguration : Triadcore.ClassLibrary.XmlConfigurationBase
    {


        #region Events
        #endregion


        #region Properties
        /// <summary>
        /// The time interval, in seconds, for service "wake-up".
        /// </summary>
        public int TimerInterval
        {
            get
            {
                return this.timerInterval;
            }
        }
        /// <summary>
        /// he Logging.LoggingDestination where messages will be logged.
        /// </summary>
        public Triadcore.ClassLibrary.LoggingDestination LoggingDestination
        {
            get
            {
                return this.loggingDesitination;
            }
        }
        #endregion


        #region Local Data Items
        // The Logging.LoggingDestination where messages will be logged.
        private Triadcore.ClassLibrary.LoggingDestination loggingDesitination = LoggingDestination.None;
        // The service timer interval.
        private int timerInterval = 0;
        #endregion


        #region Constructors
        public ServiceConfiguration(string configFilePath) : base(configFilePath)
        {
        }
        public ServiceConfiguration(string configFilePath, bool throwExceptionOnMissingNode) : base(configFilePath, throwExceptionOnMissingNode)
        {
        }
        #endregion


        #region Methods
        /// <summary>
        /// Overrides XmlConfigurationBase.LoadDataItems(). Sets the local data items.
        /// </summary>
        protected override void LoadDataItems()
        {

            string methodName = System.Reflection.MethodInfo.GetCurrentMethod().Name + "()";

            try
            {

                // Timer interval.
                this.timerInterval = Convert.ToInt32(this.GetDataItem("TimerInterval"));

                // Logging destination.
                string ld = this.GetDataItem("LoggingDestination");
                if (ld != null)
                {
                    switch (ld.ToUpper())
                    {
                        case ("XMLFILE"):
                            this.loggingDesitination = Triadcore.ClassLibrary.LoggingDestination.XMLFile;
                            break;
                        case ("TEXTFILE"):
                            this.loggingDesitination = Triadcore.ClassLibrary.LoggingDestination.TextFile;
                            break;
                        case ("LOCALEVENTLOG"):
                            this.loggingDesitination = Triadcore.ClassLibrary.LoggingDestination.LocalEventLog;
                            break;
                        default:
                            throw new Exception("The configuration file LoggingDestination is not valid.");
                            break;
                    }  // switch (ld.ToUpper())
                }

            }
            catch (Exception ex)
            {
                throw new Exception("An exception occured in method " + methodName + " while attempting to retrieve configuration data items. Exception message is: " + ex.Message);
            }

            return;

        }
        #endregion


        #region Event Handlers
        #endregion


    }


}

