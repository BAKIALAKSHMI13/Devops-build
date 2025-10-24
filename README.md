# Devops-build Project: CI/CD Deployment with Monitoring (Jenkins + Docker + AWS + Uptime Kuma)
🔧 Project Overview
This project shows how we can take a simple React application and make it production-ready. We’ll containerize it using Docker, automate builds with Jenkins, host it on AWS, and keep an eye on it with monitoring tools. By the end, you’ll see how all the DevOps stages connect in a real-world pipeline.
🧩 Tech Stack

AWS EC2 – Hosting Jenkins and Docker containers
Jenkins – CI/CD automation for build and deployment
Docker – Containerization of the application
Docker Hub – Image repository for build artifacts
Uptime Kuma – Monitoring application health with email alerts
GitHub – Source code and project documentation

Steps:
1.	Clone the Repo: First, we need the source code. We’ll clone it from GitHub. This is just a React app, so nothing scary. React normally runs on port 3000, but in production, we’ll make it run on port 80 so anyone can open it in a browser without typing the port.
Command:
git clone https://github.com/sriram-R-krishnan/devops-build.git
cd devops-build

2.	Dockerize the App: Next, we need to package the app into a container. Containers make sure it runs the same way on our laptop, in Jenkins, and on AWS. We use a Dockerfile for this.
We’ll build the React app with Node, then serve the built files with nginx, a fast web server.
Show [Dockerfile] code. Explain “multi-stage build” (first stage = build, second stage = run).

3.	Docker Compose: Instead of running long Docker commands every time, Docker Compose gives us a simple config file. It tells Docker to run our image and expose it on port 80.
Show [docker-compose.yml]
Command:
chmod +x build.sh deploy.sh

4.	Automation with Scripts: To avoid typing the same commands again and again, we create scripts.
	*build.sh → builds the Docker image
    *deploy.sh → deploys it with Docker Compose
This is a very common DevOps habit: automate small steps to save time and avoid mistakes.”
Show both scripts.

5.	Version Control (GitHub): Now we push our changes to GitHub. We’ll use two branches:
  *dev branch → for testing builds.
  *master branch → for production builds.
This matches real-world practice where dev and prod are separate.
Commands:
git init
git checkout -b dev
git add .
git commit -m "Initial commit with dockerization"
git remote add origin https://github.com/BAKIALAKSHMI13/Devops-build
git push origin dev

6.	DockerHub Setup: DockerHub is like GitHub, but for images. We’ll create two repos:
  	*dev (public) → anyone can see/test our dev builds [bakialakshmi/dev]
    *prod (private) → only we control production builds [bakialakshmi/prod]
So, Jenkins can push different builds to different repos.
Commands:
docker tag react-app:latest bakialakshmi/dev:latest
docker push bakialakshmi/dev:latest

7.	Jenkins Setup: Jenkins is our automation engine. Every time code is pushed to GitHub, Jenkins will:
    *Pull the latest code
    *Build the Docker image
    *Push the image to DockerHub
    *Deploy it to AWS
Branch rules:
  	*Push to dev branch → image goes to dev repo.
    *Merge into master → image goes to prod repo.
Check Jenkinsfile, go through each stage to understand it better: checkout – build – push – deploy
[Make sure to install the necessary plugins like Docker, Git; and do configure their credentials for GitHub + DockerHub]

8.	AWS EC2 Setup: EC2 is just a virtual server. We’ll:
   *Launch a t2.micro instance
   *Install Docker & Docker Compose
   *Copy our deploy script to it
   *Run the container so the app is available on port 80
Security Groups:
*	Port 80 open to all → so everyone can see the app.
*	Port 22 (SSH) only for your IP → so only you can log in.
Commands:
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -aG docker ec2-user

9.	Monitoring: Finally, we need to check if the app is healthy. We’ll use an open-source tool.
   *Uptime Kuma (very simple, nice dashboard). 
[ex: docker run -d --restart=always -p 3001:3001 --name uptime-kuma louislam/uptime-kuma]
-	Access http://3.110.77.55:3001
-	Add monitor for http://3.110.77.55:80

10.	Project Submission:
      *GitHub repo URL
      *DockerHub repos (dev + prod)
      *Jenkins screenshots (config + build logs)
      *AWS screenshots (instance + SG rules)
      *Running site URL
      *Monitoring dashboard screenshot.



