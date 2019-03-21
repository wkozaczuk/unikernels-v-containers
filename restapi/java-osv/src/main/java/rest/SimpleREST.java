package rest;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.core.json.JsonArray;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.BodyHandler;

import java.util.HashMap;
import java.util.Map;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SimpleREST extends AbstractVerticle {

  // Convenience method so you can run it in your IDE
  public static void main(String[] args) {
    Vertx vertx = Vertx.vertx();

    DeploymentOptions options = new DeploymentOptions();
    options.setInstances(Runtime.getRuntime().availableProcessors());

    System.out.println("Detected " + Runtime.getRuntime().availableProcessors() + " CPUs and " + 
       (Runtime.getRuntime().totalMemory() / (1024 * 1024)) + "MB of memory");
    System.out.println("Listening on port 8080 ...");

    vertx.deployVerticle(SimpleREST.class, options);
  }

  private Map<String, JsonObject> todos = new HashMap<>();

  @Override
  public void start() {

    setUpInitialData();

    Router router = Router.router(vertx);

    router.route().handler(BodyHandler.create());
    router.get("/todos/:todoId").handler(this::handleTodo);
    router.get("/todos").handler(this::handleTodosIndex);
    router.get("/").handler(this::handleIndex);

    vertx.createHttpServer().requestHandler(router::accept).listen(8080);
  }

  private void handleTodo(RoutingContext routingContext) {
    String productID = routingContext.request().getParam("todoId");
    HttpServerResponse response = routingContext.response();
    if (productID == null) {
      sendError(400, response);
    } else {
      JsonObject product = todos.get(productID);
      if (product == null) {
        sendError(404, response);
      } else {
        response.putHeader("content-type", "application/json").end(product.encodePrettily());
      }
    }
  }

  private void handleIndex(RoutingContext routingContext) {
    routingContext.response().putHeader("content-type", "application/json").end("");
  }

  private void handleTodosIndex(RoutingContext routingContext) {
    JsonArray arr = new JsonArray();
    todos.forEach((k, v) -> arr.add(v));
    routingContext.response().putHeader("content-type", "application/json").end(arr.encodePrettily());
  }

  private void sendError(int statusCode, HttpServerResponse response) {
    response.setStatusCode(statusCode).end();
  }

  private void setUpInitialData() {
    addTodo(new JsonObject().put("id", "1").put("name", "Write presentation").put("completed", "false").put("due", new SimpleDateFormat("dd-MM-yyyy").format(new Date())));
    addTodo(new JsonObject().put("id", "2").put("name", "Host meetup").put("completed", "false").put("due", new SimpleDateFormat("dd-MM-yyyy").format(new Date())));
    addTodo(new JsonObject().put("id", "3").put("name", "Run tests").put("completed", "false").put("due", new SimpleDateFormat("dd-MM-yyyy").format(new Date())));
    addTodo(new JsonObject().put("id", "4").put("name", "Stand in traffic").put("completed", "false").put("due", new SimpleDateFormat("dd-MM-yyyy").format(new Date())));
    addTodo(new JsonObject().put("id", "5").put("name", "Learn Vertx").put("completed", "false").put("due", new SimpleDateFormat("dd-MM-yyyy").format(new Date())));
  }

  private void addTodo(JsonObject todo) {
    todos.put(todo.getString("id"), todo);
  }
}
