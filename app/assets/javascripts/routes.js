(function() {
  var NodeTypes, ParameterMissing, Utils, createGlobalJsRoutesObject, defaults, root,
    __hasProp = {}.hasOwnProperty;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  ParameterMissing = function(message) {
    this.message = message;
  };

  ParameterMissing.prototype = new Error();

  defaults = {
    prefix: "",
    default_url_options: {}
  };

  NodeTypes = {"GROUP":1,"CAT":2,"SYMBOL":3,"OR":4,"STAR":5,"LITERAL":6,"SLASH":7,"DOT":8};

  Utils = {
    serialize: function(object, prefix) {
      var element, i, key, prop, result, s, _i, _len;

      if (prefix == null) {
        prefix = null;
      }
      if (!object) {
        return "";
      }
      if (!prefix && !(this.get_object_type(object) === "object")) {
        throw new Error("Url parameters should be a javascript hash");
      }
      if (root.jQuery) {
        result = root.jQuery.param(object);
        return (!result ? "" : result);
      }
      s = [];
      switch (this.get_object_type(object)) {
        case "array":
          for (i = _i = 0, _len = object.length; _i < _len; i = ++_i) {
            element = object[i];
            s.push(this.serialize(element, prefix + "[]"));
          }
          break;
        case "object":
          for (key in object) {
            if (!__hasProp.call(object, key)) continue;
            prop = object[key];
            if (!(prop != null)) {
              continue;
            }
            if (prefix != null) {
              key = "" + prefix + "[" + key + "]";
            }
            s.push(this.serialize(prop, key));
          }
          break;
        default:
          if (object) {
            s.push("" + (encodeURIComponent(prefix.toString())) + "=" + (encodeURIComponent(object.toString())));
          }
      }
      if (!s.length) {
        return "";
      }
      return s.join("&");
    },
    clean_path: function(path) {
      var last_index;

      path = path.split("://");
      last_index = path.length - 1;
      path[last_index] = path[last_index].replace(/\/+/g, "/");
      return path.join("://");
    },
    set_default_url_options: function(optional_parts, options) {
      var i, part, _i, _len, _results;

      _results = [];
      for (i = _i = 0, _len = optional_parts.length; _i < _len; i = ++_i) {
        part = optional_parts[i];
        if (!options.hasOwnProperty(part) && defaults.default_url_options.hasOwnProperty(part)) {
          _results.push(options[part] = defaults.default_url_options[part]);
        }
      }
      return _results;
    },
    extract_anchor: function(options) {
      var anchor;

      anchor = "";
      if (options.hasOwnProperty("anchor")) {
        anchor = "#" + options.anchor;
        delete options.anchor;
      }
      return anchor;
    },
    extract_trailing_slash: function(options) {
      var trailing_slash;

      trailing_slash = false;
      if (defaults.default_url_options.hasOwnProperty("trailing_slash")) {
        trailing_slash = defaults.default_url_options.trailing_slash;
      }
      if (options.hasOwnProperty("trailing_slash")) {
        trailing_slash = options.trailing_slash;
        delete options.trailing_slash;
      }
      return trailing_slash;
    },
    extract_options: function(number_of_params, args) {
      var last_el;

      last_el = args[args.length - 1];
      if (args.length > number_of_params || ((last_el != null) && "object" === this.get_object_type(last_el) && !this.look_like_serialized_model(last_el))) {
        return args.pop();
      } else {
        return {};
      }
    },
    look_like_serialized_model: function(object) {
      return "id" in object || "to_param" in object;
    },
    path_identifier: function(object) {
      var property;

      if (object === 0) {
        return "0";
      }
      if (!object) {
        return "";
      }
      property = object;
      if (this.get_object_type(object) === "object") {
        if ("to_param" in object) {
          property = object.to_param;
        } else if ("id" in object) {
          property = object.id;
        } else {
          property = object;
        }
        if (this.get_object_type(property) === "function") {
          property = property.call(object);
        }
      }
      return property.toString();
    },
    clone: function(obj) {
      var attr, copy, key;

      if ((obj == null) || "object" !== this.get_object_type(obj)) {
        return obj;
      }
      copy = obj.constructor();
      for (key in obj) {
        if (!__hasProp.call(obj, key)) continue;
        attr = obj[key];
        copy[key] = attr;
      }
      return copy;
    },
    prepare_parameters: function(required_parameters, actual_parameters, options) {
      var i, result, val, _i, _len;

      result = this.clone(options) || {};
      for (i = _i = 0, _len = required_parameters.length; _i < _len; i = ++_i) {
        val = required_parameters[i];
        if (i < actual_parameters.length) {
          result[val] = actual_parameters[i];
        }
      }
      return result;
    },
    build_path: function(required_parameters, optional_parts, route, args) {
      var anchor, opts, parameters, result, trailing_slash, url, url_params;

      args = Array.prototype.slice.call(args);
      opts = this.extract_options(required_parameters.length, args);
      if (args.length > required_parameters.length) {
        throw new Error("Too many parameters provided for path");
      }
      parameters = this.prepare_parameters(required_parameters, args, opts);
      this.set_default_url_options(optional_parts, parameters);
      anchor = this.extract_anchor(parameters);
      trailing_slash = this.extract_trailing_slash(parameters);
      result = "" + (this.get_prefix()) + (this.visit(route, parameters));
      url = Utils.clean_path("" + result);
      if (trailing_slash === true) {
        url = url.replace(/(.*?)[\/]?$/, "$1/");
      }
      if ((url_params = this.serialize(parameters)).length) {
        url += "?" + url_params;
      }
      url += anchor;
      return url;
    },
    visit: function(route, parameters, optional) {
      var left, left_part, right, right_part, type, value;

      if (optional == null) {
        optional = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return this.visit(left, parameters, true);
        case NodeTypes.STAR:
          return this.visit_globbing(left, parameters, true);
        case NodeTypes.LITERAL:
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
          return left;
        case NodeTypes.CAT:
          left_part = this.visit(left, parameters, optional);
          right_part = this.visit(right, parameters, optional);
          if (optional && !(left_part && right_part)) {
            return "";
          }
          return "" + left_part + right_part;
        case NodeTypes.SYMBOL:
          value = parameters[left];
          if (value != null) {
            delete parameters[left];
            return this.path_identifier(value);
          }
          if (optional) {
            return "";
          } else {
            throw new ParameterMissing("Route parameter missing: " + left);
          }
          break;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    build_path_spec: function(route, wildcard) {
      var left, right, type;

      if (wildcard == null) {
        wildcard = false;
      }
      type = route[0], left = route[1], right = route[2];
      switch (type) {
        case NodeTypes.GROUP:
          return "(" + (this.build_path_spec(left)) + ")";
        case NodeTypes.CAT:
          return "" + (this.build_path_spec(left)) + (this.build_path_spec(right));
        case NodeTypes.STAR:
          return this.build_path_spec(left, true);
        case NodeTypes.SYMBOL:
          if (wildcard === true) {
            return "" + (left[0] === '*' ? '' : '*') + left;
          } else {
            return ":" + left;
          }
          break;
        case NodeTypes.SLASH:
        case NodeTypes.DOT:
        case NodeTypes.LITERAL:
          return left;
        default:
          throw new Error("Unknown Rails node type");
      }
    },
    visit_globbing: function(route, parameters, optional) {
      var left, right, type, value;

      type = route[0], left = route[1], right = route[2];
      if (left.replace(/^\*/i, "") !== left) {
        route[1] = left = left.replace(/^\*/i, "");
      }
      value = parameters[left];
      if (value == null) {
        return this.visit(route, parameters, optional);
      }
      parameters[left] = (function() {
        switch (this.get_object_type(value)) {
          case "array":
            return value.join("/");
          default:
            return value;
        }
      }).call(this);
      return this.visit(route, parameters, optional);
    },
    get_prefix: function() {
      var prefix;

      prefix = defaults.prefix;
      if (prefix !== "") {
        prefix = (prefix.match("/$") ? prefix : "" + prefix + "/");
      }
      return prefix;
    },
    route: function(required_parts, optional_parts, route_spec) {
      var path_fn;

      path_fn = function() {
        return Utils.build_path(required_parts, optional_parts, route_spec, arguments);
      };
      path_fn.required_params = required_parts;
      path_fn.toString = function() {
        return Utils.build_path_spec(route_spec);
      };
      return path_fn;
    },
    _classToTypeCache: null,
    _classToType: function() {
      var name, _i, _len, _ref;

      if (this._classToTypeCache != null) {
        return this._classToTypeCache;
      }
      this._classToTypeCache = {};
      _ref = "Boolean Number String Function Array Date RegExp Object Error".split(" ");
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        this._classToTypeCache["[object " + name + "]"] = name.toLowerCase();
      }
      return this._classToTypeCache;
    },
    get_object_type: function(obj) {
      if (root.jQuery && (root.jQuery.type != null)) {
        return root.jQuery.type(obj);
      }
      if (obj == null) {
        return "" + obj;
      }
      if (typeof obj === "object" || typeof obj === "function") {
        return this._classToType()[Object.prototype.toString.call(obj)] || "object";
      } else {
        return typeof obj;
      }
    }
  };

  createGlobalJsRoutesObject = function() {
    var namespace;

    namespace = function(mainRoot, namespaceString) {
      var current, parts;

      parts = (namespaceString ? namespaceString.split(".") : []);
      if (!parts.length) {
        return;
      }
      current = parts.shift();
      mainRoot[current] = mainRoot[current] || {};
      return namespace(mainRoot[current], parts.join("."));
    };
    namespace(root, "Routes");
    root.Routes = {
// api_v1_artist => /api/v1/artists/:id(.:format)
  // function(id, options)
  api_v1_artist_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"v1",false],[2,[7,"/",false],[2,[6,"artists",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_v1_car_error_index => /api/v1/car/error(.:format)
  // function(options)
  api_v1_car_error_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"v1",false],[2,[7,"/",false],[2,[6,"car",false],[2,[7,"/",false],[2,[6,"error",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_v1_car_list_index => /api/v1/car/list(.:format)
  // function(options)
  api_v1_car_list_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"v1",false],[2,[7,"/",false],[2,[6,"car",false],[2,[7,"/",false],[2,[6,"list",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_v1_car_pointback_index => /api/v1/car/pointback(.:format)
  // function(options)
  api_v1_car_pointback_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"v1",false],[2,[7,"/",false],[2,[6,"car",false],[2,[7,"/",false],[2,[6,"pointback",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// api_v1_home_index => /api/v1/home(.:format)
  // function(options)
  api_v1_home_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"api",false],[2,[7,"/",false],[2,[6,"v1",false],[2,[7,"/",false],[2,[6,"home",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_artist => /app/artists/:id(.:format)
  // function(id, options)
  app_artist_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"artists",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_car_error_index => /app/car/error(.:format)
  // function(options)
  app_car_error_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"car",false],[2,[7,"/",false],[2,[6,"error",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_car_list_index => /app/car/list(.:format)
  // function(options)
  app_car_list_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"car",false],[2,[7,"/",false],[2,[6,"list",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_event => /app/events/:id(.:format)
  // function(id, options)
  app_event_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_event_comment => /app/events/:event_id/comments/:id(.:format)
  // function(event_id, id, options)
  app_event_comment_path: Utils.route(["event_id","id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"event_id",false],[2,[7,"/",false],[2,[6,"comments",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]]]], arguments),
// app_event_comments => /app/events/:event_id/comments(.:format)
  // function(event_id, options)
  app_event_comments_path: Utils.route(["event_id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"event_id",false],[2,[7,"/",false],[2,[6,"comments",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// app_events => /app/events(.:format)
  // function(options)
  app_events_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_menu_index => /app/menu(.:format)
  // function(options)
  app_menu_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"menu",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_products => /app/products(.:format)
  // function(options)
  app_products_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"products",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_profile_index => /app/profile(.:format)
  // function(options)
  app_profile_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"profile",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_purchase_index => /app/purchase(.:format)
  // function(options)
  app_purchase_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"purchase",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_root => /app(.:format)
  // function(options)
  app_root_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// app_user => /app/users/:id(.:format)
  // function(id, options)
  app_user_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[3,"id",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// app_users => /app/users(.:format)
  // function(options)
  app_users_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"users",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// app_version_index => /app/version(.:format)
  // function(options)
  app_version_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"version",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// batch_action_admin_artist_groups => /admin/artist_groups/batch_action(.:format)
  // function(options)
  batch_action_admin_artist_groups_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artist_groups",false],[2,[7,"/",false],[2,[6,"batch_action",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// batch_action_admin_artists => /admin/artists/batch_action(.:format)
  // function(options)
  batch_action_admin_artists_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artists",false],[2,[7,"/",false],[2,[6,"batch_action",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// batch_action_admin_items => /admin/items/batch_action(.:format)
  // function(options)
  batch_action_admin_items_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"items",false],[2,[7,"/",false],[2,[6,"batch_action",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// batch_action_admin_purchased_items => /admin/purchased_items/batch_action(.:format)
  // function(options)
  batch_action_admin_purchased_items_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"purchased_items",false],[2,[7,"/",false],[2,[6,"batch_action",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// batch_action_admin_staffs => /admin/staffs/batch_action(.:format)
  // function(options)
  batch_action_admin_staffs_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"staffs",false],[2,[7,"/",false],[2,[6,"batch_action",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// destroy_staff_session => /admin/logout(.:format)
  // function(options)
  destroy_staff_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"logout",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// edit_admin_artist => /admin/artists/:id/edit(.:format)
  // function(id, options)
  edit_admin_artist_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artists",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_artist_group => /admin/artist_groups/:id/edit(.:format)
  // function(id, options)
  edit_admin_artist_group_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artist_groups",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_item => /admin/items/:id/edit(.:format)
  // function(id, options)
  edit_admin_item_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"items",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_purchased_item => /admin/purchased_items/:id/edit(.:format)
  // function(id, options)
  edit_admin_purchased_item_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"purchased_items",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_admin_staff => /admin/staffs/:id/edit(.:format)
  // function(id, options)
  edit_admin_staff_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"staffs",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_app_event => /app/events/:id/edit(.:format)
  // function(id, options)
  edit_app_event_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_app_event_comment => /app/events/:event_id/comments/:id/edit(.:format)
  // function(event_id, id, options)
  edit_app_event_comment_path: Utils.route(["event_id","id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"event_id",false],[2,[7,"/",false],[2,[6,"comments",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]]]]]], arguments),
// edit_app_user => /app/users/:id/edit(.:format)
  // function(id, options)
  edit_app_user_path: Utils.route(["id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[3,"id",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]], arguments),
// edit_staff_password => /admin/password/edit(.:format)
  // function(options)
  edit_staff_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"password",false],[2,[7,"/",false],[2,[6,"edit",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_artist => /admin/artists/new(.:format)
  // function(options)
  new_admin_artist_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artists",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_artist_group => /admin/artist_groups/new(.:format)
  // function(options)
  new_admin_artist_group_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"artist_groups",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_item => /admin/items/new(.:format)
  // function(options)
  new_admin_item_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"items",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_purchased_item => /admin/purchased_items/new(.:format)
  // function(options)
  new_admin_purchased_item_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"purchased_items",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_admin_staff => /admin/staffs/new(.:format)
  // function(options)
  new_admin_staff_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"staffs",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_app_event => /app/events/new(.:format)
  // function(options)
  new_app_event_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_app_event_comment => /app/events/:event_id/comments/new(.:format)
  // function(event_id, options)
  new_app_event_comment_path: Utils.route(["event_id"], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"events",false],[2,[7,"/",false],[2,[3,"event_id",false],[2,[7,"/",false],[2,[6,"comments",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]]]]]], arguments),
// new_app_user => /app/users/new(.:format)
  // function(options)
  new_app_user_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"app",false],[2,[7,"/",false],[2,[6,"users",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_staff_password => /admin/password/new(.:format)
  // function(options)
  new_staff_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"password",false],[2,[7,"/",false],[2,[6,"new",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// new_staff_session => /admin/login(.:format)
  // function(options)
  new_staff_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"login",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// peek.results => /peek/results(.:format)
  // function(options)
  peek_results_path: Utils.route([], ["format"], [2,[2,[2,[7,"/",false],[6,"peek",false]],[7,"/",false]],[2,[6,"results",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// privacy_index => /privacy(.:format)
  // function(options)
  privacy_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"privacy",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// rails_info => /rails/info(.:format)
  // function(options)
  rails_info_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// rails_info_properties => /rails/info/properties(.:format)
  // function(options)
  rails_info_properties_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"properties",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_info_routes => /rails/info/routes(.:format)
  // function(options)
  rails_info_routes_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"info",false],[2,[7,"/",false],[2,[6,"routes",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]]]], arguments),
// rails_mailers => /rails/mailers(.:format)
  // function(options)
  rails_mailers_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"rails",false],[2,[7,"/",false],[2,[6,"mailers",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// rambulance_exceptions_app => /rambulance
  // function(options)
  rambulance_exceptions_app_path: Utils.route([], [], [2,[7,"/",false],[6,"rambulance",false]], arguments),
// root => /
  // function(options)
  root_path: Utils.route([], [], [7,"/",false], arguments),
// staff_password => /admin/password(.:format)
  // function(options)
  staff_password_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"password",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// staff_session => /admin/login(.:format)
  // function(options)
  staff_session_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"admin",false],[2,[7,"/",false],[2,[6,"login",false],[1,[2,[8,".",false],[3,"format",false]],false]]]]], arguments),
// support_index => /support(.:format)
  // function(options)
  support_index_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"support",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments),
// terms => /terms(.:format)
  // function(options)
  terms_path: Utils.route([], ["format"], [2,[7,"/",false],[2,[6,"terms",false],[1,[2,[8,".",false],[3,"format",false]],false]]], arguments)}
;
    root.Routes.options = defaults;
    return root.Routes;
  };

  if (typeof define === "function" && define.amd) {
    define([], function() {
      return createGlobalJsRoutesObject();
    });
  } else {
    createGlobalJsRoutesObject();
  }

}).call(this);
