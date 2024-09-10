	
# Specify Base Image
FROM docker.io/node:18-alpine
 
# Work Directory
WORKDIR /usr/app

#copying file
COPY ./ ./
 
# Install Dependencies
RUN npm install
 
# Startup Command
CMD ["npm", "start"]