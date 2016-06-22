require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"firebase":[function(require,module,exports){
var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

exports.Firebase = (function(superClass) {
  var getCORSurl, request;

  extend(Firebase, superClass);

  getCORSurl = function(server, path, secret, project) {
    var url;
    switch (Utils.isWebKit()) {
      case true:
        url = "https://" + server + path + ".json?auth=" + secret + "&ns=" + project + "&sse=true";
        break;
      default:
        url = "https://" + project + ".firebaseio.com" + path + ".json?auth=" + secret;
    }
    return url;
  };

  Firebase.define("status", {
    get: function() {
      return this._status;
    }
  });

  function Firebase(options) {
    var base, base1, base2, base3;
    this.options = options != null ? options : {};
    this.projectID = (base = this.options).projectID != null ? base.projectID : base.projectID = null;
    this.secret = (base1 = this.options).secret != null ? base1.secret : base1.secret = null;
    this.server = (base2 = this.options).server != null ? base2.server : base2.server = void 0;
    this.debug = (base3 = this.options).debug != null ? base3.debug : base3.debug = false;
    if (this._status == null) {
      this._status = "disconnected";
    }
    Firebase.__super__.constructor.apply(this, arguments);
    if (this.server === void 0) {
      Utils.domLoadJSON("https://" + this.projectID + ".firebaseio.com/.settings/owner.json", function(a, server) {
        var msg;
        print(msg = "Add ______ server:" + '   "' + server + '"' + " _____ to your instance of Firebase.");
        if (this.debug) {
          return console.log("Firebase: " + msg);
        }
      });
    }
    if (this.debug) {
      console.log("Firebase: Connecting to Firebase Project '" + this.projectID + "' ... \n URL: '" + (getCORSurl(this.server, "/", this.secret, this.projectID)) + "'");
    }
    this.onChange("connection");
  }

  request = function(project, secret, path, callback, method, data, parameters, debug) {
    var url, xhttp;
    url = "https://" + project + ".firebaseio.com" + path + ".json?auth=" + secret;
    if (parameters !== void 0) {
      if (parameters.shallow) {
        url += "&shallow=true";
      }
      if (parameters.format === "export") {
        url += "&format=export";
      }
      switch (parameters.print) {
        case "pretty":
          url += "&print=pretty";
          break;
        case "silent":
          url += "&print=silent";
      }
      if (typeof parameters.download === "string") {
        url += "&download=" + parameters.download;
        window.open(url, "_self");
      }
      if (typeof parameters.orderBy === "string") {
        url += "&orderBy=" + '"' + parameters.orderBy + '"';
      }
      if (typeof parameters.limitToFirst === "number") {
        url += "&limitToFirst=" + parameters.limitToFirst;
      }
      if (typeof parameters.limitToLast === "number") {
        url += "&limitToLast=" + parameters.limitToLast;
      }
      if (typeof parameters.startAt === "number") {
        url += "&startAt=" + parameters.startAt;
      }
      if (typeof parameters.endAt === "number") {
        url += "&endAt=" + parameters.endAt;
      }
      if (typeof parameters.equalTo === "number") {
        url += "&equalTo=" + parameters.equalTo;
      }
    }
    xhttp = new XMLHttpRequest;
    if (debug) {
      console.log("Firebase: New '" + method + "'-request with data: '" + (JSON.stringify(data)) + "' \n URL: '" + url + "'");
    }
    xhttp.onreadystatechange = (function(_this) {
      return function() {
        if (parameters !== void 0) {
          if (parameters.print === "silent" || typeof parameters.download === "string") {
            return;
          }
        }
        switch (xhttp.readyState) {
          case 0:
            if (debug) {
              console.log("Firebase: Request not initialized \n URL: '" + url + "'");
            }
            break;
          case 1:
            if (debug) {
              console.log("Firebase: Server connection established \n URL: '" + url + "'");
            }
            break;
          case 2:
            if (debug) {
              console.log("Firebase: Request received \n URL: '" + url + "'");
            }
            break;
          case 3:
            if (debug) {
              console.log("Firebase: Processing request \n URL: '" + url + "'");
            }
            break;
          case 4:
            if (callback != null) {
              callback(JSON.parse(xhttp.responseText));
            }
            if (debug) {
              console.log("Firebase: Request finished, response: '" + (JSON.parse(xhttp.responseText)) + "' \n URL: '" + url + "'");
            }
        }
        if (xhttp.status === "404") {
          if (debug) {
            return console.warn("Firebase: Invalid request, page not found \n URL: '" + url + "'");
          }
        }
      };
    })(this);
    xhttp.open(method, url, true);
    xhttp.setRequestHeader("Content-type", "application/json; charset=utf-8");
    return xhttp.send(data = "" + (JSON.stringify(data)));
  };

  Firebase.prototype.get = function(path, callback, parameters) {
    return request(this.projectID, this.secret, path, callback, "GET", null, parameters, this.debug);
  };

  Firebase.prototype.put = function(path, data, callback, parameters) {
    return request(this.projectID, this.secret, path, callback, "PUT", data, parameters, this.debug);
  };

  Firebase.prototype.post = function(path, data, callback, parameters) {
    return request(this.projectID, this.secret, path, callback, "POST", data, parameters, this.debug);
  };

  Firebase.prototype.patch = function(path, data, callback, parameters) {
    return request(this.projectID, this.secret, path, callback, "PATCH", data, parameters, this.debug);
  };

  Firebase.prototype["delete"] = function(path, callback, parameters) {
    return request(this.projectID, this.secret, path, callback, "DELETE", null, parameters, this.debug);
  };

  Firebase.prototype.onChange = function(path, callback) {
    var currentStatus, source, url;
    if (path === "connection") {
      url = getCORSurl(this.server, "/", this.secret, this.projectID);
      currentStatus = "disconnected";
      source = new EventSource(url);
      source.addEventListener("open", (function(_this) {
        return function() {
          if (currentStatus === "disconnected") {
            _this._status = "connected";
            if (callback != null) {
              callback("connected");
            }
            if (_this.debug) {
              console.log("Firebase: Connection to Firebase Project '" + _this.projectID + "' established");
            }
          }
          return currentStatus = "connected";
        };
      })(this));
      return source.addEventListener("error", (function(_this) {
        return function() {
          if (currentStatus === "connected") {
            _this._status = "disconnected";
            if (callback != null) {
              callback("disconnected");
            }
            if (_this.debug) {
              console.warn("Firebase: Connection to Firebase Project '" + _this.projectID + "' closed");
            }
          }
          return currentStatus = "disconnected";
        };
      })(this));
    } else {
      url = getCORSurl(this.server, path, this.secret, this.projectID);
      source = new EventSource(url);
      if (this.debug) {
        console.log("Firebase: Listening to changes made to '" + path + "' \n URL: '" + url + "'");
      }
      source.addEventListener("put", (function(_this) {
        return function(ev) {
          if (callback != null) {
            callback(JSON.parse(ev.data).data, "put", JSON.parse(ev.data).path, _.tail(JSON.parse(ev.data).path.split("/"), 1));
          }
          if (_this.debug) {
            return console.log("Firebase: Received changes made to '" + path + "' via 'PUT': " + (JSON.parse(ev.data).data) + " \n URL: '" + url + "'");
          }
        };
      })(this));
      return source.addEventListener("patch", (function(_this) {
        return function(ev) {
          if (callback != null) {
            callback(JSON.parse(ev.data).data, "patch", JSON.parse(ev.data).path, _.tail(JSON.parse(ev.data).path.split("/"), 1));
          }
          if (_this.debug) {
            return console.log("Firebase: Received changes made to '" + path + "' via 'PATCH': " + (JSON.parse(ev.data).data) + " \n URL: '" + url + "'");
          }
        };
      })(this));
    }
  };

  return Firebase;

})(Framer.BaseClass);


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset:utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyaWZ5L25vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZnBlcmV6L1Byb3llY3Rvcy9GcmFtZXIvY291bnRlci5mcmFtZXIvbW9kdWxlcy9maXJlYmFzZS5jb2ZmZWUiLCIvVXNlcnMvZnBlcmV6L1Byb3llY3Rvcy9GcmFtZXIvY291bnRlci5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUE7QUNpQkEsSUFBQTs7O0FBQU0sT0FBTyxDQUFDO0FBSWIsTUFBQTs7OztFQUFBLFVBQUEsR0FBYSxTQUFDLE1BQUQsRUFBUyxJQUFULEVBQWUsTUFBZixFQUF1QixPQUF2QjtBQUVaLFFBQUE7QUFBQSxZQUFPLEtBQUssQ0FBQyxRQUFOLENBQUEsQ0FBUDtBQUFBLFdBQ00sSUFETjtRQUNnQixHQUFBLEdBQU0sVUFBQSxHQUFXLE1BQVgsR0FBb0IsSUFBcEIsR0FBeUIsYUFBekIsR0FBc0MsTUFBdEMsR0FBNkMsTUFBN0MsR0FBbUQsT0FBbkQsR0FBMkQ7QUFBM0U7QUFETjtRQUVnQixHQUFBLEdBQU0sVUFBQSxHQUFXLE9BQVgsR0FBbUIsaUJBQW5CLEdBQW9DLElBQXBDLEdBQXlDLGFBQXpDLEdBQXNEO0FBRjVFO0FBSUEsV0FBTztFQU5LOztFQVNiLFFBQUMsQ0FBQyxNQUFGLENBQVMsUUFBVCxFQUNDO0lBQUEsR0FBQSxFQUFLLFNBQUE7YUFBRyxJQUFDLENBQUE7SUFBSixDQUFMO0dBREQ7O0VBR2Esa0JBQUMsT0FBRDtBQUNaLFFBQUE7SUFEYSxJQUFDLENBQUEsNEJBQUQsVUFBUztJQUN0QixJQUFDLENBQUEsU0FBRCxpREFBcUIsQ0FBQyxnQkFBRCxDQUFDLFlBQWE7SUFDbkMsSUFBQyxDQUFBLE1BQUQsZ0RBQXFCLENBQUMsY0FBRCxDQUFDLFNBQWE7SUFDbkMsSUFBQyxDQUFBLE1BQUQsZ0RBQXFCLENBQUMsY0FBRCxDQUFD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QyxJQUFyQixDQUE1RCxHQUFzRixZQUF0RixHQUFrRyxHQUFsRyxHQUFzRyxHQUFsSCxFQUFBOztRQUZnQztNQUFBLENBQUEsQ0FBQSxDQUFBLElBQUEsQ0FBakMsRUEvQkQ7O0VBSFM7Ozs7R0FqR29CLE1BQU0sQ0FBQzs7OztBQ2J0QyxPQUFPLENBQUMsS0FBUixHQUFnQjs7QUFFaEIsT0FBTyxDQUFDLFVBQVIsR0FBcUIsU0FBQTtTQUNwQixLQUFBLENBQU0sdUJBQU47QUFEb0I7O0FBR3JCLE9BQU8sQ0FBQyxPQUFSLEdBQWtCLENBQUMsQ0FBRCxFQUFJLENBQUosRUFBTyxDQUFQIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIlxuXG5cbiMgJ0ZpcmViYXNlIFJFU1QgQVBJIENsYXNzJyBtb2R1bGUgdjEuMFxuIyBieSBNYXJjIEtyZW5uLCBKdW5lIDIybmQsIDIwMTYgfCBtYXJjLmtyZW5uQGdtYWlsLmNvbSB8IEBtYXJjX2tyZW5uXG5cbiMgRG9jdW1lbnRhdGlvbiBvZiB0aGlzIE1vZHVsZTogaHR0cHM6Ly9naXRodWIuY29tL21hcmNrcmVubi9mcmFtZXItRmlyZWJhc2VcbiMgLS0tLS0tIDogLS0tLS0tLSBGaXJlYmFzZSBSRVNUIEFQSTogaHR0cHM6Ly9maXJlYmFzZS5nb29nbGUuY29tL2RvY3MvcmVmZXJlbmNlL3Jlc3QvZGF0YWJhc2UvXG5cblxuIyBUb0RvOlxuIyBGaXggb25DaGFuZ2UgXCJjb25uZWN0aW9uXCIsIGB0aGlzwrQgY29udGV4dFxuXG5cblxuIyBGaXJlYmFzZSBSRVNUIEFQSSBDbGFzcyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tXG5cbmNsYXNzIGV4cG9ydHMuRmlyZWJhc2UgZXh0ZW5kcyBGcmFtZXIuQmFzZUNsYXNzXG5cblxuXG5cdGdldENPUlN1cmwgPSAoc2VydmVyLCBwYXRoLCBzZWNyZXQsIHByb2plY3QpIC0+XG5cblx0XHRzd2l0Y2ggVXRpbHMuaXNXZWJLaXQoKVxuXHRcdFx0d2hlbiB0cnVlIHRoZW4gdXJsID0gXCJodHRwczovLyN7c2VydmVyfSN7cGF0aH0uanNvbj9hdXRoPSN7c2VjcmV0fSZucz0je3Byb2plY3R9JnNzZT10cnVlXCIgIyBXZWJraXQgWFNTIHdvcmthcm91bmRcblx0XHRcdGVsc2UgICAgICAgICAgIHVybCA9IFwiaHR0cHM6Ly8je3Byb2plY3R9LmZpcmViYXNlaW8uY29tI3twYXRofS5qc29uP2F1dGg9I3tzZWNyZXR9XCJcblxuXHRcdHJldHVybiB1cmxcblxuXG5cdEAuZGVmaW5lIFwic3RhdHVzXCIsXG5cdFx0Z2V0OiAtPiBAX3N0YXR1cyAjIHJlYWRPbmx5XG5cblx0Y29uc3RydWN0b3I6IChAb3B0aW9ucz17fSkgLT5cblx0XHRAcHJvamVjdElEID0gQG9wdGlvbnMucHJvamVjdElEID89IG51bGxcblx0XHRAc2VjcmV0ICAgID0gQG9wdGlvbnMuc2VjcmV0ICAgID89IG51bGxcblx0XHRAc2VydmVyICAgID0gQG9wdGlvbnMuc2VydmVyICAgID89IHVuZGVmaW5lZCAjIHJlcXVpcmVkIGZvciBXZWJLaXQgWFNTIHdvcmthcm91bmRcblx0XHRAZGVidWcgICAgID0gQG9wdGlvbnMuZGVidWcgICAgID89IGZhbHNlXG5cdFx0QF9zdGF0dXMgICAgICAgICAgICAgICAgICAgICAgICA/PSBcImRpc2Nvbm5lY3RlZFwiXG5cdFx0c3VwZXJcblxuXG5cdFx0aWYgQHNlcnZlciBpcyB1bmRlZmluZWRcblx0XHRcdFV0aWxzLmRvbUxvYWRKU09OIFwiaHR0cHM6Ly8je0Bwcm9qZWN0SUR9LmZpcmViYXNlaW8uY29tLy5zZXR0aW5ncy9vd25lci5qc29uXCIsIChhLHNlcnZlcikgLT5cblx0XHRcdFx0cHJpbnQgbXNnID0gXCJBZGQgX19fX19fIHNlcnZlcjpcIiArICcgICBcIicgKyBzZXJ2ZXIgKyAnXCInICsgXCIgX19fX18gdG8geW91ciBpbnN0YW5jZSBvZiBGaXJlYmFzZS5cIlxuXHRcdFx0XHRjb25zb2xlLmxvZyBcIkZpcmViYXNlOiAje21zZ31cIiBpZiBAZGVidWdcblxuXG5cdFx0Y29uc29sZS5sb2cgXCJGaXJlYmFzZTogQ29ubmVjdGluZyB0byBGaXJlYmFzZSBQcm9qZWN0ICcje0Bwcm9qZWN0SUR9JyAuLi4gXFxuIFVSTDogJyN7Z2V0Q09SU3VybChAc2VydmVyLCBcIi9cIiwgQHNlY3JldCwgQHByb2plY3RJRCl9J1wiIGlmIEBkZWJ1Z1xuXHRcdEAub25DaGFuZ2UgXCJjb25uZWN0aW9uXCJcblxuXG5cdHJlcXVlc3QgPSAocHJvamVjdCwgc2VjcmV0LCBwYXRoLCBjYWxsYmFjaywgbWV0aG9kLCBkYXRhLCBwYXJhbWV0ZXJzLCBkZWJ1ZykgLT5cblxuXHRcdHVybCA9IFwiaHR0cHM6Ly8je3Byb2plY3R9LmZpcmViYXNlaW8uY29tI3twYXRofS5qc29uP2F1dGg9I3tzZWNyZXR9XCJcblxuXG5cdFx0dW5sZXNzIHBhcmFtZXRlcnMgaXMgdW5kZWZpbmVkXG5cdFx0XHRpZiBwYXJhbWV0ZXJzLnNoYWxsb3cgICAgICAgICAgICB0aGVuIHVybCArPSBcIiZzaGFsbG93PXRydWVcIlxuXHRcdFx0aWYgcGFyYW1ldGVycy5mb3JtYXQgaXMgXCJleHBvcnRcIiB0aGVuIHVybCArPSBcIiZmb3JtYXQ9ZXhwb3J0XCJcblxuXHRcdFx0c3dpdGNoIHBhcmFtZXRlcnMucHJpbnRcblx0XHRcdFx0d2hlbiBcInByZXR0eVwiIHRoZW4gdXJsICs9IFwiJnByaW50PXByZXR0eVwiXG5cdFx0XHRcdHdoZW4gXCJzaWxlbnRcIiB0aGVuIHVybCArPSBcIiZwcmludD1zaWxlbnRcIlxuXG5cdFx0XHRpZiB0eXBlb2YgcGFyYW1ldGVycy5kb3dubG9hZCBpcyBcInN0cmluZ1wiXG5cdFx0XHRcdHVybCArPSBcIiZkb3dubG9hZD0je3BhcmFtZXRlcnMuZG93bmxvYWR9XCJcblx0XHRcdFx0d2luZG93Lm9wZW4odXJsLFwiX3NlbGZcIilcblxuXG5cdFx0XHR1cmwgKz0gXCImb3JkZXJCeT1cIiArICdcIicgKyBwYXJhbWV0ZXJzLm9yZGVyQnkgKyAnXCInIGlmIHR5cGVvZiBwYXJhbWV0ZXJzLm9yZGVyQnkgICAgICBpcyBcInN0cmluZ1wiXG5cdFx0XHR1cmwgKz0gXCImbGltaXRUb0ZpcnN0PSN7cGFyYW1ldGVycy5saW1pdFRvRmlyc3R9XCIgICBpZiB0eXBlb2YgcGFyYW1ldGVycy5saW1pdFRvRmlyc3QgaXMgXCJudW1iZXJcIlxuXHRcdFx0dXJsICs9IFwiJmxpbWl0VG9MYXN0PSN7cGFyYW1ldGVycy5saW1pdFRvTGFzdH1cIiAgICAgaWYgdHlwZW9mIHBhcmFtZXRlcnMubGltaXRUb0xhc3QgIGlzIFwibnVtYmVyXCJcblx0XHRcdHVybCArPSBcIiZzdGFydEF0PSN7cGFyYW1ldGVycy5zdGFydEF0fVwiICAgICAgICAgICAgIGlmIHR5cGVvZiBwYXJhbWV0ZXJzLnN0YXJ0QXQgICAgICBpcyBcIm51bWJlclwiXG5cdFx0XHR1cmwgKz0gXCImZW5kQXQ9I3twYXJhbWV0ZXJzLmVuZEF0fVwiICAgICAgICAgICAgICAgICBpZiB0eXBlb2YgcGFyYW1ldGVycy5lbmRBdCAgICAgICAgaXMgXCJudW1iZXJcIlxuXHRcdFx0dXJsICs9IFwiJmVxdWFsVG89I3twYXJhbWV0ZXJzLmVxdWFsVG99XCIgICAgICAgICAgICAgaWYgdHlwZW9mIHBhcmFtZXRlcnMuZXF1YWxUbyAgICAgIGlzIFwibnVtYmVyXCJcblxuXG5cdFx0eGh0dHAgPSBuZXcgWE1MSHR0cFJlcXVlc3Rcblx0XHRjb25zb2xlLmxvZyBcIkZpcmViYXNlOiBOZXcgJyN7bWV0aG9kfSctcmVxdWVzdCB3aXRoIGRhdGE6ICcje0pTT04uc3RyaW5naWZ5KGRhdGEpfScgXFxuIFVSTDogJyN7dXJsfSdcIiBpZiBkZWJ1Z1xuXHRcdHhodHRwLm9ucmVhZHlzdGF0ZWNoYW5nZSA9ID0+XG5cblx0XHRcdHVubGVzcyBwYXJhbWV0ZXJzIGlzIHVuZGVmaW5lZFxuXHRcdFx0XHRpZiBwYXJhbWV0ZXJzLnByaW50IGlzIFwic2lsZW50XCIgb3IgdHlwZW9mIHBhcmFtZXRlcnMuZG93bmxvYWQgaXMgXCJzdHJpbmdcIiB0aGVuIHJldHVybiAjIHVnaFxuXG5cdFx0XHRzd2l0Y2ggeGh0dHAucmVhZHlTdGF0ZVxuXHRcdFx0XHR3aGVuIDAgdGhlbiBjb25zb2xlLmxvZyBcIkZpcmViYXNlOiBSZXF1ZXN0IG5vdCBpbml0aWFsaXplZCBcXG4gVVJMOiAnI3t1cmx9J1wiICAgICAgIGlmIGRlYnVnXG5cdFx0XHRcdHdoZW4gMSB0aGVuIGNvbnNvbGUubG9nIFwiRmlyZWJhc2U6IFNlcnZlciBjb25uZWN0aW9uIGVzdGFibGlzaGVkIFxcbiBVUkw6ICcje3VybH0nXCIgaWYgZGVidWdcblx0XHRcdFx0d2hlbiAyIHRoZW4gY29uc29sZS5sb2cgXCJGaXJlYmFzZTogUmVxdWVzdCByZWNlaXZlZCBcXG4gVVJMOiAnI3t1cmx9J1wiICAgICAgICAgICAgICBpZiBkZWJ1Z1xuXHRcdFx0XHR3aGVuIDMgdGhlbiBjb25zb2xlLmxvZyBcIkZpcmViYXNlOiBQcm9jZXNzaW5nIHJlcXVlc3QgXFxuIFVSTDogJyN7dXJsfSdcIiAgICAgICAgICAgIGlmIGRlYnVnXG5cdFx0XHRcdHdoZW4gNFxuXHRcdFx0XHRcdGNhbGxiYWNrKEpTT04ucGFyc2UoeGh0dHAucmVzcG9uc2VUZXh0KSkgaWYgY2FsbGJhY2s/XG5cdFx0XHRcdFx0Y29uc29sZS5sb2cgXCJGaXJlYmFzZTogUmVxdWVzdCBmaW5pc2hlZCwgcmVzcG9uc2U6ICcje0pTT04ucGFyc2UoeGh0dHAucmVzcG9uc2VUZXh0KX0nIFxcbiBVUkw6ICcje3VybH0nXCIgaWYgZGVidWdcblxuXHRcdFx0aWYgeGh0dHAuc3RhdHVzIGlzIFwiNDA0XCJcblx0XHRcdFx0Y29uc29sZS53YXJuIFwiRmlyZWJhc2U6IEludmFsaWQgcmVxdWVzdCwgcGFnZSBub3QgZm91bmQgXFxuIFVSTDogJyN7dXJsfSdcIiBpZiBkZWJ1Z1xuXG5cblx0XHR4aHR0cC5vcGVuKG1ldGhvZCwgdXJsLCB0cnVlKVxuXHRcdHhodHRwLnNldFJlcXVlc3RIZWFkZXIoXCJDb250ZW50LXR5cGVcIiwgXCJhcHBsaWNhdGlvbi9qc29uOyBjaGFyc2V0PXV0Zi04XCIpXG5cdFx0eGh0dHAuc2VuZChkYXRhID0gXCIje0pTT04uc3RyaW5naWZ5KGRhdGEpfVwiKVxuXG5cblxuXHQjIEF2YWlsYWJsZSBtZXRob2RzXG5cblx0Z2V0OiAgICAocGF0aCwgY2FsbGJhY2ssICAgICAgIHBhcmFtZXRlcnMpIC0+IHJlcXVlc3QoQHByb2plY3RJRCwgQHNlY3JldCwgcGF0aCwgY2FsbGJhY2ssIFwiR0VUXCIsICAgIG51bGwsIHBhcmFtZXRlcnMsIEBkZWJ1Zylcblx0cHV0OiAgICAocGF0aCwgZGF0YSwgY2FsbGJhY2ssIHBhcmFtZXRlcnMpIC0+IHJlcXVlc3QoQHByb2plY3RJRCwgQHNlY3JldCwgcGF0aCwgY2FsbGJhY2ssIFwiUFVUXCIsICAgIGRhdGEsIHBhcmFtZXRlcnMsIEBkZWJ1Zylcblx0cG9zdDogICAocGF0aCwgZGF0YSwgY2FsbGJhY2ssIHBhcmFtZXRlcnMpIC0+IHJlcXVlc3QoQHByb2plY3RJRCwgQHNlY3JldCwgcGF0aCwgY2FsbGJhY2ssIFwiUE9TVFwiLCAgIGRhdGEsIHBhcmFtZXRlcnMsIEBkZWJ1Zylcblx0cGF0Y2g6ICAocGF0aCwgZGF0YSwgY2FsbGJhY2ssIHBhcmFtZXRlcnMpIC0+IHJlcXVlc3QoQHByb2plY3RJRCwgQHNlY3JldCwgcGF0aCwgY2FsbGJhY2ssIFwiUEFUQ0hcIiwgIGRhdGEsIHBhcmFtZXRlcnMsIEBkZWJ1Zylcblx0ZGVsZXRlOiAocGF0aCwgY2FsbGJhY2ssICAgICAgIHBhcmFtZXRlcnMpIC0+IHJlcXVlc3QoQHByb2plY3RJRCwgQHNlY3JldCwgcGF0aCwgY2FsbGJhY2ssIFwiREVMRVRFXCIsIG51bGwsIHBhcmFtZXRlcnMsIEBkZWJ1ZylcblxuXG5cblx0b25DaGFuZ2U6IChwYXRoLCBjYWxsYmFjaykgLT5cblxuXG5cdFx0aWYgcGF0aCBpcyBcImNvbm5lY3Rpb25cIlxuXG5cdFx0XHR1cmwgPSBnZXRDT1JTdXJsKEBzZXJ2ZXIsIFwiL1wiLCBAc2VjcmV0LCBAcHJvamVjdElEKVxuXHRcdFx0Y3VycmVudFN0YXR1cyA9IFwiZGlzY29ubmVjdGVkXCJcblx0XHRcdHNvdXJjZSA9IG5ldyBFdmVudFNvdXJjZSh1cmwpXG5cblx0XHRcdHNvdXJjZS5hZGRFdmVudExpc3RlbmVyIFwib3BlblwiLCA9PlxuXHRcdFx0XHRpZiBjdXJyZW50U3RhdHVzIGlzIFwiZGlzY29ubmVjdGVkXCJcblx0XHRcdFx0XHRALl9zdGF0dXMgPSBcImNvbm5lY3RlZFwiXG5cdFx0XHRcdFx0Y2FsbGJhY2soXCJjb25uZWN0ZWRcIikgaWYgY2FsbGJhY2s/XG5cdFx0XHRcdFx0Y29uc29sZS5sb2cgXCJGaXJlYmFzZTogQ29ubmVjdGlvbiB0byBGaXJlYmFzZSBQcm9qZWN0ICcje0Bwcm9qZWN0SUR9JyBlc3RhYmxpc2hlZFwiIGlmIEBkZWJ1Z1xuXHRcdFx0XHRjdXJyZW50U3RhdHVzID0gXCJjb25uZWN0ZWRcIlxuXG5cdFx0XHRzb3VyY2UuYWRkRXZlbnRMaXN0ZW5lciBcImVycm9yXCIsID0+XG5cdFx0XHRcdGlmIGN1cnJlbnRTdGF0dXMgaXMgXCJjb25uZWN0ZWRcIlxuXHRcdFx0XHRcdEAuX3N0YXR1cyA9IFwiZGlzY29ubmVjdGVkXCJcblx0XHRcdFx0XHRjYWxsYmFjayhcImRpc2Nvbm5lY3RlZFwiKSBpZiBjYWxsYmFjaz9cblx0XHRcdFx0XHRjb25zb2xlLndhcm4gXCJGaXJlYmFzZTogQ29ubmVjdGlvbiB0byBGaXJlYmFzZSBQcm9qZWN0ICcje0Bwcm9qZWN0SUR9JyBjbG9zZWRcIiBpZiBAZGVidWdcblx0XHRcdFx0Y3VycmVudFN0YXR1cyA9IFwiZGlzY29ubmVjdGVkXCJcblxuXG5cdFx0ZWxzZVxuXG5cdFx0XHR1cmwgPSBnZXRDT1JTdXJsKEBzZXJ2ZXIsIHBhdGgsIEBzZWNyZXQsIEBwcm9qZWN0SUQpXG5cdFx0XHRzb3VyY2UgPSBuZXcgRXZlbnRTb3VyY2UodXJsKVxuXHRcdFx0Y29uc29sZS5sb2cgXCJGaXJlYmFzZTogTGlzdGVuaW5nIHRvIGNoYW5nZXMgbWFkZSB0byAnI3twYXRofScgXFxuIFVSTDogJyN7dXJsfSdcIiBpZiBAZGVidWdcblxuXHRcdFx0c291cmNlLmFkZEV2ZW50TGlzdGVuZXIgXCJwdXRcIiwgKGV2KSA9PlxuXHRcdFx0XHRjYWxsYmFjayhKU09OLnBhcnNlKGV2LmRhdGEpLmRhdGEsIFwicHV0XCIsIEpTT04ucGFyc2UoZXYuZGF0YSkucGF0aCwgXy50YWlsKEpTT04ucGFyc2UoZXYuZGF0YSkucGF0aC5zcGxpdChcIi9cIiksMSkpIGlmIGNhbGxiYWNrP1xuXHRcdFx0XHRjb25zb2xlLmxvZyBcIkZpcmViYXNlOiBSZWNlaXZlZCBjaGFuZ2VzIG1hZGUgdG8gJyN7cGF0aH0nIHZpYSAnUFVUJzogI3tKU09OLnBhcnNlKGV2LmRhdGEpLmRhdGF9IFxcbiBVUkw6ICcje3VybH0nXCIgaWYgQGRlYnVnXG5cblx0XHRcdHNvdXJjZS5hZGRFdmVudExpc3RlbmVyIFwicGF0Y2hcIiwgKGV2KSA9PlxuXHRcdFx0XHRjYWxsYmFjayhKU09OLnBhcnNlKGV2LmRhdGEpLmRhdGEsIFwicGF0Y2hcIiwgSlNPTi5wYXJzZShldi5kYXRhKS5wYXRoLCBfLnRhaWwoSlNPTi5wYXJzZShldi5kYXRhKS5wYXRoLnNwbGl0KFwiL1wiKSwxKSkgaWYgY2FsbGJhY2s/XG5cdFx0XHRcdGNvbnNvbGUubG9nIFwiRmlyZWJhc2U6IFJlY2VpdmVkIGNoYW5nZXMgbWFkZSB0byAnI3twYXRofScgdmlhICdQQVRDSCc6ICN7SlNPTi5wYXJzZShldi5kYXRhKS5kYXRhfSBcXG4gVVJMOiAnI3t1cmx9J1wiIGlmIEBkZWJ1Z1xuIiwiIyBBZGQgdGhlIGZvbGxvd2luZyBsaW5lIHRvIHlvdXIgcHJvamVjdCBpbiBGcmFtZXIgU3R1ZGlvLiBcbiMgbXlNb2R1bGUgPSByZXF1aXJlIFwibXlNb2R1bGVcIlxuIyBSZWZlcmVuY2UgdGhlIGNvbnRlbnRzIGJ5IG5hbWUsIGxpa2UgbXlNb2R1bGUubXlGdW5jdGlvbigpIG9yIG15TW9kdWxlLm15VmFyXG5cbmV4cG9ydHMubXlWYXIgPSBcIm15VmFyaWFibGVcIlxuXG5leHBvcnRzLm15RnVuY3Rpb24gPSAtPlxuXHRwcmludCBcIm15RnVuY3Rpb24gaXMgcnVubmluZ1wiXG5cbmV4cG9ydHMubXlBcnJheSA9IFsxLCAyLCAzXSJdfQ==
