# Before writing anything, the Dockerfile needs to tell Docker:
# Which environment should I use? → Node.js
# Where should my application live inside the container?
# Which files should I copy into it?
# Which port does my application use? → 3000
# What command should run when the container starts? → start app.js


# We don't need RUN npm install for your current application because you're only using Node's built-in http module and have no external dependencies.


# Uses Node.js 22 as the base environment for your container.
FROM node:22


# Creates/uses /app as the working directory inside the container.
WORKDIR /app


# Copies your local app.js into /app inside the container.
COPY app.js .


# Documents that your Node application uses port 3000.
EXPOSE 3000

# Tells Docker to run your Node application when the container starts.
CMD ["node" , "app.js"]


# docker build -t node-app .  :  Docker reads the Dockerfile in the current folder, builds an image from it, and names that image node-app.