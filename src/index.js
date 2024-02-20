import APP from "./app.js";
import { server } from "./config/environments.js";

// SERVER LISTENING
APP.listen(server.PORT, () => {
  console.log(`Server running at http://${server.HOSTNAME}:${server.PORT}`);
});
