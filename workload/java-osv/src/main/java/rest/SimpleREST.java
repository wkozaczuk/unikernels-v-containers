package rest;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.core.json.JsonArray;
import io.vertx.core.json.JsonObject;
import io.vertx.core.json.Json;
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

    vertx.deployVerticle(new SimpleREST());
  }

  private Map<String, JsonObject> todos = new HashMap<>();

  @Override
  public void start() {
    Router router = Router.router(vertx);

    router.route().handler(BodyHandler.create());
    router.post("/sort").handler(this::handleSort);

    vertx.createHttpServer().requestHandler(router::accept).listen(8080);
  }

  private void handleSort(RoutingContext routingContext) {
    String productID = routingContext.request().getParam("todoId");
    
    int[] numbers = Json.decodeValue(routingContext.getBodyAsString(), int[].class);
    int[] sorted = bubbleSort(numbers);
    HttpServerResponse response = routingContext.response();

    response.putHeader("content-type", "application/json").end(Json.encodePrettily(sorted));
  }

  private void sendError(int statusCode, HttpServerResponse response) {
    response.setStatusCode(statusCode).end();
  }

  private int[] bubbleSort(int arr[]) {
      int n = arr.length;
      for (int i = 0; i < n-1; i++) {
          for (int j = 0; j < n-i-1; j++) {
              if (arr[j] > arr[j+1]) {
                  int temp = arr[j];
                  arr[j] = arr[j+1];
                  arr[j+1] = temp;
              }
          }
      }
    
      return arr;
  }
}
