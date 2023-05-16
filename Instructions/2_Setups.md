# 2-Setups

## 2-BioHPC

BioHPC is the high-performance computing group at UT Southwestern. They offer a range of computational resources, workshops, and cloud storage options specifically designed for research labs on campus. This section provides a brief overview of getting started with BioHPC, but it does not cover every resource they offer in detail.

To access comprehensive documentation and PowerPoint slides on using BioHPC's resources, visit their website: [BioHPC Portal](https://portal.biohpc.swmed.edu). These resources will provide you with step-by-step instructions and in-depth explanations of various tools and services.

If you have any specific questions or need assistance, you can reach out to BioHPC's support team by sending an email to biohpc-help@utsouthwestern.edu. They will be happy to help you with any issues or inquiries related to BioHPC.

BioHPC's cloud storage options, computational resources, and workshops are invaluable assets for conducting research. Make sure to explore their offerings and utilize them effectively to enhance your work in the lab.

## 2.1 Getting Access

To obtain access to BioHPC, you need to follow these steps:

1. Register for an account on the BioHPC website.
2. Attend the orientation workshop, which takes place on the first Wednesday of every month.
3. To sign up for the session, send an email to the support team. They will provide you with further details and confirm your attendance.

After attending the orientation workshop, your account will be activated, granting you access to BioHPC's resources.

## 2.2 Directory Organization

Once your account is activated, you will have access to three directories: `/home2`, `/work`, and `/project`. Here's a breakdown of their purposes:

- `/home2`: This directory serves as your home directory, and your personal folder will be located at `/home2/[your UT Southwestern ID]`. It is recommended to use this directory primarily for backing up your code, as it has a storage limit of 50 GB.

- `/work`: Your work directory is where you should conduct your analysis and save the results such as plots, matrices, and other output files. This directory offers a more substantial storage capacity of 5 TB, making it suitable for storing and working with larger datasets.

When performing your analysis and saving outputs, make sure to utilize your `/work` directory to ensure you don't exceed the storage limits.

Properly organizing and utilizing these directories will help you manage your work efficiently and ensure you have sufficient storage space for your research activities on BioHPC.

## Project Directory (/project)

In the BioHPC environment, the project directory (`/project`) is where data for every lab is stored. As a member of our lab, you will have access to our specific lab's data, located at `/project/TIBIR/Lega lab/shared/lega ansir/`.

Within the project directory, there are several folders, but the two key folders you should be familiar with are:

1. **shared code**: This folder contains essential resources for our lab's analyses. It includes a master EEG toolbox that covers various analysis tasks, data processing functions (such as event-making), and lab tutorials for different tasks.

2. **subjFiles**: This folder houses all the subject-specific data for our lab. The individual folders within `subjFiles` are organized as follows:

   - **behavioral**: This folder contains behavioral data for all the tasks performed by the patients. The data is organized as event structures.

   - **docs**: Here, you'll find miscellaneous text files with electrode labels, including jacksheets, depth electrode information, and other relevant documentation.

   - **eeg.noreref**: This folder stores the raw EEG files for all recorded channels during the testing sessions.

   - **eeg.reref**: Similar to the `eeg.noreref` folder, this folder also contains raw EEG files. However, the values in this folder are recalculated using an average rereferencing scheme. These files are typically used for aligning event structures.

   - **freesurfer**: This folder contains CT and MRI files obtained from the FreeSurfer software.

   - **raw**: Here, you will find the original EEG files directly from the clinical recording systems. These files have extensions like `.EEG`, `.21E`, or `.ns2`.

   - **tal**: The `tal` folder contains information on the localization of electrodes. It includes a structure that provides Talairach coordinates for individual electrode contacts.

By familiarizing yourself with these specific folders within the `subjFiles` directory, you'll be able to access and work with the relevant data and resources needed for your analyses in our lab.

Remember to adhere to any data handling and access protocols established within the lab to ensure the security and integrity of the data.


## 2.3 Working on the Cloud

There are multiple ways to access and work with data from the lab directory on the BioHPC cloud. The most efficient method is to use the Web Visualization feature provided by BioHPC. This allows you to remotely control a node on the cluster, essentially providing you with a cloud-based computer environment. Follow these steps to set it up:

1. Download TurboVNC from the official website: [TurboVNC](https://www.turbovnc.org). TurboVNC sets up the graphical user interface (GUI) for the Web Visualization.

2. Start the Web Visualization from the BioHPC website. It will provide you with a node address and a password.

3. Launch TurboVNC and enter the node address and password when prompted. If everything is set up correctly, a Linux desktop will appear (Figure 1). The GUI will function like a regular computer, with various software preinstalled, including Matlab, Python, R, and more.

4. To start a program, open a terminal window by going to "Applications" -> "System Tools" at the top left-hand corner of the screen.

5. For example, to start an instance of Matlab, check the available Matlab versions by typing `module avail matlab` in the terminal. Choose your preferred version (avoid version 2017 due to a bug explained later), and load it with the command `module load matlab/[version]`. Finally, start Matlab by typing `matlab`.

6. You can start other modules in a similar way by loading them correctly. To see the complete list of available modules, type `module avail` in the terminal.

Another method to access data on BioHPC is by mounting the cloud directories to your local device. Follow these steps for macOS:

1. Open any Finder window and click on "Go" -> "Connect to Server" in the toolbar at the top of your screen.

2. Enter the following server addresses based on the directory you want to access:
   - `/home2`: `smb://lamella.biohpc.swmed.edu/<username>`
   - `/project`: `smb://lamella.biohpc.swmed.edu/project`
   - `/work`: `smb://lamella.biohpc.swmed.edu/work`

3. You will be prompted to enter your BioHPC account information to log in.

This method is particularly useful when transferring small files to and from the server, accessing analysis outputs, and performing offline plotting. However, it is not recommended to perform extensive troubleshooting or plotting directly on the cloud, especially when dealing with a large number of output files. Navigation and plotting with Matlab on BioHPC may be slower and can lead to formatting issues that are not experienced offline.

By using either the Web Visualization or mounting the cloud directories, you can efficiently access and work with the lab data on BioHPC, depending on your specific needs and tasks.

Regarding the lack of proper graphics drivers for the Web Visualization on Windows machines, please refer to the BioHPC introductions page for detailed instructions: [BioHPC Introduction Page](https://portal.biohpc.swmed.edu/content/guides/introduction-biohpc/).

For setting up Matlab on the cloud, follow these steps to ensure that your user preferences and paths are properly configured:

1. Open Matlab on the cloud.

2. By default, Matlab recognizes your `/home2` directory as the initial folder. However, it is more efficient to work from and save your outputs to your `/work` directory. To modify this setting, click on the "Home" tab and go to "Preferences".

3. In the left-hand side menu, select "General". Under "Initial working folder", choose the "Custom" option. Then, navigate to your `/work` folder by clicking the "..." button on the right. Apply the changes by clicking "Apply" and "OK" to confirm.

   Note: If you are using a 2017 version of Matlab, this setting may be bugged, so it is recommended to choose an earlier version where you can modify the initial working path.

4. Next, you need to set up the paths for Matlab to recognize the locations of your functions, scripts, and toolboxes. Create a new script from the "Home" tab and name it `startup.m`. Save it to your initial working directory (`/work`).

5. Inside the `startup.m` script, add the following two lines of code:
   ```matlab
   addpath(genpath('/work/TIBIR/Lega lab/[your ID]'));
   addpath(genpath('/project/TIBIR/Lega lab/shared/lega ansir/shared code'));
   ```

   This script will run every time Matlab starts up and automatically load code from your `/work` directory and the lab's master EEG toolbox without requiring manual intervention.

6. Restart Matlab and the terminal to confirm the change in the initial working directory displayed in the current folder.

7. To check if your code has been properly added, you can use the `which` function. For example, to check if `gete ms.m` has been added, type `which gete ms.m` in the Matlab terminal. If the output returns a directory, it means the startup script is working correctly.

Please note that these setup steps only apply to the Matlab version you are currently using. If you go through these steps for one version (e.g., 2016b), the changes will not be reflected when you try to start another version. It is recommended to pick one version and stick with it to maintain consistent settings and configurations. For the purpose of executing any tutorial code, you should copy the shared code folder to your local directory, add it to your local Matlab’s path, and have the lab project directory mounted.

## 2.4 Running Parallel Jobs

BioHPC offers the capability to perform computations in parallel, allowing for faster processing of tasks. To utilize parallel computing, follow these guidelines and use the provided code and scripts in the `/shared code/tutorial/parallel jobs` directory:

1. All the necessary code and scripts for running parallel jobs can be found in the `/shared code/tutorial/parallel jobs` directory.

2. To organize your script for parallel processing, follow these guidelines:
   - Structure your script around a main for loop that you want to process in parallel.
   - Embed the main body of the code inside a try/catch statement. This ensures that each iteration of the loop is independent, and any errors that occur in one iteration do not interfere with others.
   - Organize the inputs into a Matlab structure (e.g., subject, electrode, regions) for sequential processing within the main for loop.
   - For each iteration of the loop, generate a "lock" file if the iteration is attempted or performed, a "done" file if completed without error, or an "error" file if an error occurs. These empty text files provide insights into the progress and results of each iteration based on their names.

   Refer to `lockfile template.m` in the tutorial folder for more detailed information on setting up your script in this format.

3. To submit a job to the cloud, you need to use two shell scripts: `srunScript.sh` and `matlabWrapper.sh`. Copy both of these files into your `/work` folder to use them for your own jobs.

4. Modify the necessary parts of these scripts to fit your specific use case. The templates are labeled to indicate the sections that need modification. Make the required changes to adapt the scripts for your job.

5. Once you have made the necessary modifications, use the Nucleus Web Terminal on the BioHPC homepage to submit the job. Type the following command:
   ```
   sbatch /work/[location of your srunScript.sh]
   ```

   This command submits the job with the specified parameters and calls the `matlabWrapper.sh` script to start the job.

Please refer to the job submission tutorial on the BioHPC homepage for more detailed information on the job submission process and additional parameters you can configure.

By following these steps and utilizing the provided code and scripts, you can harness the power of parallel computing on BioHPC to improve the efficiency of your computations.

## 2.5 Access from Off Campus

If you need to access BioHPC from off campus, you can do so by following these steps:

1. Download and install Pulse Secure, which is a virtual private network (VPN) client used to connect to the campus network. You can find the download link and detailed instructions on the intranet page: [Pulse Secure Download](http://www.utsouthwestern.net/intranet/administration/information-resources/network/vpn/).

2. Once you have installed Pulse Secure, start the program.

3. Add a connection to the server by entering the server name as "utswra.swmed.edu".

4. Enter your UTSW (UT Southwestern) password when prompted.

5. Pulse Secure will then prompt you for a secondary password, which you can obtain through the Duo Mobile app. Follow the instructions provided to authenticate your login.

6. Once the program confirms a successful connection to the campus network, you can access BioHPC as you would normally, just as if you were on campus.

By using Pulse Secure and establishing a VPN connection to the campus network, you can securely access BioHPC from off-campus locations and continue your work remotely.


